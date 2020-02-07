#! /bin/bash
usage() {
  echo "NO arguments found use an argument as your user name in the command"
}
if [[ "${#}" -eq 0 ]]
then
  usage
  exit 1
else if [[ "${UID}" -eq 0 ]]
then
  USER_NAME=${1}
  PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
  useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null
  if [[ "${?}" -ne 0 ]]
  then
    echo 'The useradd command did not execute successfully.'
    exit 1
  fi
  echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null
  if [[ "${?}" -ne 0 ]]
  then
    echo 'The password command did not execute successfully.' &> /dev/null
    exit 1
  fi
  passwd -e ${USER_NAME} &> /dev/null
  echo -e "\nusername:"
  echo  "${USER_NAME}"

  echo -e "\npassword:"
  echo "${PASSWORD}"

  echo -e '\nhost:'
  echo "${HOSTNAME}"
else
  echo 'You are not root.'
  exit 1
fi
fi
