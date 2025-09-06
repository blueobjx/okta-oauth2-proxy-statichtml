#!/bin/bash

# refer to https://github.com/blueobjx/okta-oauth2-proxy-statichtml

# Add --user $(id -u):$(id -g) to run rootless

docker run --rm \
    -v $(pwd)/static-html:/var/static-html \
    -p "${OPSH_SITE_PORT}:4180" \
    quay.io/oauth2-proxy/oauth2-proxy \
    --provider oidc \
    --oidc-issuer-url "${OPSH_OKTA_ISSUER}" \
    --upstream "file:///var/static-html/#/" \
    --http-address ":4180" \
    --email-domain=* \
    --scope "openid profile email" \
    --cookie-expire 0h0m30s \
    --session-cookie-minimal true \
    --skip-provider-button true \
    --cookie-secret "${OPSH_COOKIE_SECRET}" \
    --client-id "${OPSH_CLIENT_ID}" \
    --client-secret "${OPSH_CLIENT_SECRET}" \
    --cookie-csrf-per-request=true \
    --redirect-url "${OPSH_REDIRECT_URL}/oauth2/callback" \
    --cookie-secure false \
    --cookie-csrf-expire 5m
