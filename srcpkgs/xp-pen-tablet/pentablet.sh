#!/bin/sh

user="$(who | awk '{print $1}' | head -1)"
userHomeDir="$(getent passwd "${user}" | cut -d: -f6)"

userConfDir="${userHomeDir}/.local/share/pentablet"

appDir='/usr/lib/pentablet'
appName='pentablet'

mkdir -p "${userConfDir}"
chmod -R 755 "${userConfDir}"

sysConfName='config.xml'
sysLangName='language.ini'
sysNameConfName='name_config.ini'

rootConfDir="${appDir}/conf/xppen"

if [ ! -f "${userConfDir}/${sysConfName}" ]; then
  cp "${rootConfDir}/${sysConfName}" "${userConfDir}/${sysConfName}"
fi

if [ ! -f "${userConfDir}/${sysLangName}" ]; then
  cp "${rootConfDir}/${sysLangName}" "${userConfDir}/${sysLangName}"
fi

if [ ! -f "${userConfDir}/${sysNameConfName}" ]; then
  cp "${rootConfDir}/${sysNameConfName}" "${userConfDir}/${sysNameConfName}"
fi

export LD_LIBRARY_PATH="${appDir}/lib"
exec "${appDir}/${appName}" "$@"

