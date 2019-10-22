const audioContext = new (window.AudioContext || window.webkitAudioContext)();

const oggBuf2wavBuf = oggBuf =>
  new Promise((resolve, reject) =>
    Module.then(Module => {
      Module["FS"].writeFile("audio.ogg", new Int8Array(oggBuf));
      Module["callMain"](["--quiet", "audio.ogg"]); //"--quiet",
      resolve(Module["FS"].readFile("audio.wav").buffer);
    })
  );

Module["decodeOggData"] = oggBuffer =>
  new Promise(resolve =>
    oggBuf2wavBuf(oggBuffer).then(wavBuffer =>
      audioContext.decodeAudioData(wavBuffer, resolve)
    )
  );



// var oggNeedsHelp = window.webkitAudioContext;
// oggNeedsHelp = false;

//
// const decodeOggData = oggBuffer => {
//   return new Promise((resolve, reject) => {
//     if (oggNeedsHelp) {
//       oggBuf2wavBuf(oggBuffer).then(wavBuffer => {
//         audioContext.decodeAudioData(wavBuffer, resolve);
//       });
//     } else {
//       audioContext.decodeAudioData(oggBuffer, resolve, () => {
//         oggNeedsHelp = true;
//         oggBuf2wavBuf(oggBuffer).then(wavBuffer => {
//           audioContext.decodeAudioData(wavBuffer, resolve);
//         });
//       });
//     }
//   });
// };

// export default decodeOggData;
