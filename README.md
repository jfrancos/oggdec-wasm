# oggdec-wasm

Decode ogg files in the browser using vorbis tools' oggdec via emscripten.

Build it from scratch by just downloading the Makefile and pre.js, run make, and then:

```
<script type="module">
  import {decodeOggDecModule} from "./oggdec.js";
  const {decodeOggData} = decodeOggDecModule();
  const decodedData = decodeOggData([...some array buffer...]);
</script>
```

(Compiles on Mac, not tested on Linux)
