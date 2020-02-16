OGG_FILE=libogg-1.3.4
VORBIS_FILE=libvorbis-1.3.6
TOOLS_FILE=vorbis-tools-1.4.0
PREFIX=${PWD}



oggdec.js: ${TOOLS_FILE}/oggdec/oggdec.o pre.js
	EMCC_CLOSURE_ARGS="--language_in ECMASCRIPT6" \
	emcc ${TOOLS_FILE}/oggdec/oggdec.o -o oggdec.js \
	-O3 --closure 1 --llvm-lto 1 \
	--pre-js pre.js  \
	-s EXTRA_EXPORTED_RUNTIME_METHODS='["FS", "callMain"]' \
	-s SINGLE_FILE=1 \
	-s MODULARIZE=1 \
	-s INVOKE_RUN=0 \
	-s ENVIRONMENT=web \
	-s ERROR_ON_UNDEFINED_SYMBOLS=0 \
	-llibvorbisfile -llibvorbis -llibogg -Llib
	sed -i.bak '1s;^;\/* eslint-disable *\/;' oggdec.js

${TOOLS_FILE}/oggdec/oggdec.o: ${TOOLS_FILE}/oggdec/oggdec.c
	cd "${TOOLS_FILE}/oggdec" \
	&& emmake make

${TOOLS_FILE}/oggdec/oggdec.c: ${PREFIX}/lib/libvorbisfile.a
	curl -L "https://downloads.xiph.org/releases/vorbis/${TOOLS_FILE}.tar.gz" | tar xz
	cd "${TOOLS_FILE}" \
	&& sed -i.bak 's/x$$ac_cv_have_decl_OV_ECTL_COUPLING_SET/xyes/' configure \
	&& emconfigure ./configure --prefix=${PREFIX} \
	--disable-shared \
	--disable-oggenc \
	--disable-vorbiscomment \
	--disable-vcut \
	--disable-ogginfo \
	--disable-ogg123 \
	--disable-curltest \
	--without-speex \
	--without-flac \
	&& emmake make install \
 	&& sed -i.bak 's/#include "i18n.h"/char *_ (char *text) { return text; }/' oggdec/oggdec.c

${PREFIX}/lib/libvorbisfile.a: ${PREFIX}/lib/libogg.a
	curl -L "https://downloads.xiph.org/releases/vorbis/${VORBIS_FILE}.tar.xz" | tar xJ
	cd "${VORBIS_FILE}" \
	&& emconfigure ./configure --disable-shared --prefix="${PREFIX}" \
	&& emmake make install

${PREFIX}/lib/libogg.a:
	curl -L "https://downloads.xiph.org/releases/ogg/${OGG_FILE}.tar.xz" | tar xJ
	cd "${OGG_FILE}" \
	&& emconfigure ./configure --disable-shared --prefix="${PREFIX}" \
	&& emmake make install

