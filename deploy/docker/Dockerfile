FROM tarantool/tarantool:2.10

COPY reload.sh /usr/local/bin/reload
RUN chmod +x /usr/local/bin/reload
RUN apk add -f \
    postgresql-dev \
    bash \
    cmake \
    build-base \
    curl \
    wget \
    pcre2-dev \
    && git config --global url."https://".insteadOf git:// \
    && tarantoolctl rocks STATIC_BUILD=ON install kafka \
    && tarantoolctl rocks install http-v2-legacy \
    && tarantoolctl rocks install queue \
    && luarocks install https://raw.githubusercontent.com/igorcoding/tarantool-spacer/master/rockspecs/spacer-3.0.1-1.rockspec \
    && luarocks install https://raw.githubusercontent.com/tarantool/pg/master/pg-scm-1.rockspec \
    && tarantoolctl rocks install errors \
    && tarantoolctl rocks install icu-date \
    && tarantoolctl rocks install luatest \
    && tarantoolctl rocks install luacov \
    && tarantoolctl rocks install lrexlib-pcre2
