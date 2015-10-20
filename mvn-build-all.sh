#!/usr/bin/env bash

ARTIFACT_ID_PREFIX="terasoluna-gfw-"
TARGETS="parent common jodatime web security-core security-web jpa mybatis3 mybatis2 recommended-dependencies recommended-web-dependencies"
DEFAULT_GOALS="clean install"

commandArgs=${DEFAULT_GOALS}
if test $# -ne 0 ; then
    commandArgs=$@
fi

echo "[INFO] Start a build."

echo "[DEBUG] Command arguments : \"${commandArgs}\""

for target in ${TARGETS}; do
    artifactId=${ARTIFACT_ID_PREFIX}${target}
    if test -f ${artifactId}/pom.xml ; then
        mvn -U -f ${artifactId}/pom.xml ${commandArgs}
        buildResult=$?
        if test ${buildResult} -ne 0 ; then
            echo "[ERROR] Failed a build."
            exit ${buildResult}
        fi
    fi
done

echo "[INFO] Finish a build."