#! /bin/bash

if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
  read -p 'Enter the username to create: ' USER_NAME
  read -p 'Enter the name of the person who this account : ' COMMENT
  PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
  echo "${PASSWORD}"
  useradd -c "${COMMENT}" -m ${USER_NAME}
  if [[ "${?}" -ne 0 ]]
  then
    echo 'The useradd command did not execute successfully.'
    exit 1
  fi
  echo ${PASSWORD} | passwd --stdin ${USER_NAME}
  if [[ "${?}" -ne 0 ]]
  then
    echo 'The password command did not execute successfully.'
    exit 1
  fi
  passwd -e ${USER_NAME}
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