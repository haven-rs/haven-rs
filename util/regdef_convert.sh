#!/bin/bash

set -euo pipefail

readonly INPUT_FILE="${1:-hw_b1_regdefs.h}"
readonly OUTPUT_FILE="${2:-hw_b1_regdefs.rs}"

if [[ ! -f "${INPUT_FILE}" ]]; then
  echo "Error: Input file '${INPUT_FILE}' not found!" >&2
  exit 1
fi

cat > "${OUTPUT_FILE}" << 'HEADER'
// Copyright 2026 The ChromiumOS Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Converted to Rust by haven-rs
//
// THIS FILE IS AUTO-GENERATED - DO NOT EDIT

#![allow(dead_code)]

HEADER

grep -E '^#define GC_' "${INPUT_FILE}" | while read -r _ name value _; do
  if [[ "${name}" =~ (ifdef|ifndef|endif|WIDTH_BY_ADDR) ]]; then
    continue
  fi

  if [[ -z "${name}" || -z "${value}" ]]; then
    continue
  fi

  if [[ ! "${value}" =~ ^(0x[0-9a-fA-F]+|[0-9]+)$ ]]; then
    continue
  fi

  echo "pub const ${name}: u32 = ${value};" >> "${OUTPUT_FILE}"
done

count=$(grep -c '^pub const' "${OUTPUT_FILE}")
echo "done! wrote to ${OUTPUT_FILE} (${count} variables)"

if [[ "${count}" -gt 0 ]] && command -v rustfmt >/dev/null 2>&1; then
  rustfmt "${OUTPUT_FILE}"
fi