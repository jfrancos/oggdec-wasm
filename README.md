# oggdec-wasm

Decode ogg files in the browser using vorbis tools' oggdec via emscripten.

Most browsers play Ogg audio natively, but [Safari doesn't, nor does any iOS browser](https://caniuse.com/#feat=ogg-vorbis).  I have some Ogg piano samples that I want to use in another project I'm working on, and I don't want to exclude those browsers, nor do I want to transcode the Oggs.  So I compiled Xiph's libogg/libvorbis/vorbis-tools c libraries to WebAssembly using Emscripten.  I made a Makefile to automate the process.

The Makfile, along with pre.js, produces oggdec.js, which you can use like this:

```
import module from "./oggdec"
const Module = module()
const decodeOggData = Module.decodeOggData
const decodedData = decodeOggData([...some array buffer...])
```

Makefile tested on Mac and Linux

Instructions for installing emscripten here:

https://emscripten.org/docs/getting_started/downloads.html
