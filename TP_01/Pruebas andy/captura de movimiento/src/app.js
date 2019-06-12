/**
 * @license
 * Copyright 2018 Google Inc. All Rights Reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licnses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * =============================================================================
 */
import * as posenet from '@tensorflow-models/posenet'
import { drawKeypoints, drawSkeleton, normalizeVal } from './utils'
import io from './io'
import puntosClave from './puntosClave'

io.connect()

const config = {
  // Load the PoseNet model weights for either the 0.50, 0.75, 1.00, or 1.01 version
  mobileNetArchitecture: 0.75,
  outputStride: 16,
  imageScaleFactor: 0.5,
  minPoseConfidence: 0.1,
  minPartConfidence: 0.5,
  flipHorizontal: true // since images are being fed from a webcam
}

const videoWidth = 900
const videoHeight = videoWidth * 9/16

let trigger = false

/**
 * Loads a the camera
 */
async function setupCamera() {
  if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
    throw 'Browser API navigator.mediaDevices.getUserMedia not available';
  }

  const video = document.getElementById('video');
  video.width = videoWidth;
  video.height = videoHeight;

  const stream = await navigator.mediaDevices.getUserMedia({
    'audio': false,
    'video': {
      facingMode: 'user',
      width: videoWidth,
      height: videoHeight
    }
  });

  video.srcObject = stream;

  return new Promise(resolve => {
    video.onloadedmetadata = () => {
      resolve(video);
    };
  });
}

async function loadVideo() {
  const video = await setupCamera();
  video.play();

  return video;
}

/**
 * Feeds an image to posenet to estimate poses - this is where the magic happens.
 * This function loops with a requestAnimationFrame method.
 */
function detectPoseInRealTime(video, net) {
  const canvas = document.getElementById('output');
  const ctx = canvas.getContext('2d');

  canvas.width = videoWidth;
  canvas.height = videoHeight;

  async function poseDetectionFrame() {
    let pose = await net.estimateSinglePose(video, config.imageScaleFactor, config.flipHorizontal, config.outputStride)

    // limpia esqueleto y puntos de frame anterior
    ctx.clearRect(0, 0, videoWidth, videoHeight);

    // showVideo(ctx)

    // draw the resulting skeleton and keypoints if over certain confidence scores
    if (pose.score >= config.minPoseConfidence) {

      /*
      * Los nombres del objeto retornado por la libreria estan invertidos,
      * Las extremidades derechas en realidad son las extremidades izquierdas
      */
      puntosClave.cuerpo.muñeca = getPoint(pose.keypoints, 'rightWrist')

      /**
       * Envia cada frame posiciones x, y de la muñeca por osc mientras se detecte el punto.
      */
      if (puntosClave.cuerpo.muñeca !== 0) {
        let x = normalizeVal(puntosClave.cuerpo.muñeca.x, 0, videoWidth, 0, 1)
        let y = normalizeVal(puntosClave.cuerpo.muñeca.y, 0, videoHeight, 0, 1)
        
        io.sendMessage([x, y])
      }

      drawKeypoints(pose.keypoints, config.minPartConfidence, ctx)
      drawSkeleton(pose.keypoints, config.minPartConfidence, ctx)
    }

    requestAnimationFrame(poseDetectionFrame);
  }

  poseDetectionFrame();
}

function getPoint (keypoints, pointName) {  
  let point = keypoints.filter(point => {
    return point.part === pointName && point.score >= config.minPartConfidence
  })

  return (point[0] == undefined) ? 0 : point[0].position
}

function showVideo (ctx) {
  ctx.save();
  ctx.scale(-1, 1);
  ctx.translate(-videoWidth, 0);
  ctx.drawImage(video, 0, 0, videoWidth, videoHeight);
  ctx.restore();
}

/**
 * Kicks off the demo by loading the posenet model, finding and loading available
 * camera devices, and setting off the detectPoseInRealTime function.
 */
export async function bindPage() {
  // Load the PoseNet model weights for version 1.01
  const net = await posenet.load(config.mobileNetArchitecture);

  document.getElementById('loading').style.display = 'none';
  document.getElementById('main').style.display = 'flex';

  let video;

  try {
    video = await loadVideo();
  } catch(e) {
    let info = document.getElementById('info');
    info.textContent = "this browser does not support video capture, or this device does not have a camera";
    info.style.display = 'block';
    throw e;
  }

  detectPoseInRealTime(video, net)
}

navigator.getUserMedia = navigator.getUserMedia ||
  navigator.webkitGetUserMedia ||
  navigator.mozGetUserMedia;
bindPage(); // kick off the demo
