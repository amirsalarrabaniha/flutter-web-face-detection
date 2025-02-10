async function detectFaces(videoElementId) {
  const video = document.getElementById(videoElementId);
  const model = await faceDetection.createDetector(faceDetection.SupportedModels.MediaPipeFaceDetector);
  const faces = await model.estimateFaces(video);
  return faces;
}