{
    "subject": {
		"country": "NL",
		"organization": "joris.me"
	},
	"keyUsage": ["certSign", "crlSign"],
	"emailAddresses": ["pki@joris.me"],
	"basicConstraints": {
		"isCA": false
	},
{{- if typeIs "ed25519.PublicKey" .Insecure.CR.PublicKey }}
    "signatureAlgorithm": "Ed25519",
{{- else }}
  {{ fail "Key type must be Ed25519. Try again with --kty=OKP" }}
{{- end }}
}
