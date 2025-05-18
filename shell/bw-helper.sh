#!/usr/bin/env bash

set -euo pipefail

#  Print usage message and exit
usage() {
    cat >&2 <<EOF
BW-HELPER: get secrets via Bitwarden API

This tool requires that you have \`jq(1)\`, \`sed(1)\`, and the Bitwardern CLI
(\`bw\`) installed and somewhere in your \$PATH. You should also be logged in
to an unlocked, synced vault when you run this. See the Bitwarden CLI help
(\`bw unlock --help\`) for how to do this.

Usage: $(basename "$0") ACTION [ARGS...]

Actions:
  get-username ITEM
      Prints the username ("jrdobbs") for a vault item

  get-password ITEM
      Prints the password ("Maximum_sl@ck") for a vault item

  get-notes ITEM
      Prints the notes ("ARE YOU ABNORMAL? Then you are probably BETTER than
      most people!") for a vault item

  get-field ITEM FIELD_NAME
      Prints the value ("1-mighty-SPECIAL-thing!!!") of a custom field for
      a vault item, given the name of the custom field

  get-privatekey ITEM
    Prints the SSH private key ("---BEGIN OPENSSH PRIVATE...") for a vault item

  get-publickey ITEM
    Prints the SSH public key ("ssh-ed25519 AAAAC3NzaGr39...") for a vault item

  get-keyfingerprint ITEM
    Prints the SSH key fingerprint ("SHA256:sWAee5nGrbL0B...") for a vault item

Examples:
  $(basename "$0") get-username bobs-office
  $(basename "$0") get-password bobs-office
  $(basename "$0") get-notes bobs-office
  $(basename "$0") get-field bobs-office slack-password
  $(basename "$0") get-privatekey bobs-sshkey
  $(basename "$0") get-publickey bobs-sshkey
  $(basename "$0") get-keyfingerprint bobs-sshkey
EOF
    exit 1
}

#  Check required commands and minimum number of arguments
for cmd in jq bw sed; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: '$cmd' is not installed or not in \$PATH. Please install it." >&2
        exit 1
    fi
done

if [ $# -lt 2 ]; then
    usage
fi

action="$1"; shift

case "$action" in

    get-username)
        # one argument: the item name in Bitwarden
        if [ $# -ne 1 ]; then
          usage
        fi
        bw get username "$1"
        ;;

    get-password)
        # one argument: the item name in Bitwarden
        if [ $# -ne 1 ]; then
          usage
        fi
        bw get password "$1"
        ;;

    get-notes)
    # one argument: the item name in Bitwarden
    if [ $# -ne 1 ]; then
      usage
    fi
    # strip starting/ending double-quote marks and turn \n into newlines
    bw get item "$1" | jq .notes | sed -e 's/^"//' -e 's/"$//' -e 's/\\n/\n/g'
    ;;

    get-field)
        # two arguments: the item name in Bitwarden, and the name of the custom field
        if [ $# -ne 2 ]; then
          usage
        fi
        bw get item "$1" | jq -r ".fields[] | select(.name == \"${2}\") | .value"
        ;;

    get-privatekey)
        # one argument: the item name in Bitwarden
        if [ $# -ne 1 ]; then
          usage
        fi
        bw get item "$1" | jq ".sshKey.privateKey" | sed -e 's/^"//' -e 's/"$//'
        ;;

    get-publickey)
        # one argument: the item name in Bitwarden
        if [ $# -ne 1 ]; then
          usage
        fi
        bw get item "$1" | jq ".sshKey.publicKey" | sed -e 's/^"//' -e 's/"$//'
        ;;

    get-keyfingerprint)
        # one argument: the item name in Bitwarden
        if [ $# -ne 1 ]; then
          usage
        fi
        bw get item "$1" | jq ".sshKey.keyFingerprint" | sed -e 's/^"//' -e 's/"$//'
        ;;

    *)
        echo "Error: Unknown action '$action'." >&2
        usage
        ;;
esac
