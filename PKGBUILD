# Maintainer: Tiago Brait <tiagobrait AT gmail DOT com>

pkgname=ca-certificates-icp_br
pkgver=20161106
pkgrel=1
pkgdesc="Brazilian government Certification Authorities"
arch=('any')
url="http://www.iti.gov.br/icp-brasil/certificados/188-atualizacao/4530-ac-raiz"
license=('GPL')
depends=('ca-certificates-utils')
makedepends=('unzip' 'openssl')
source=(
    "icpbr_certs-${pkgver}.zip::http://acraiz.icpbrasil.gov.br/credenciadas/CertificadosAC-ICP-Brasil/ACcompactado.zip"
    )

sha512sums=('123ee1a3e04c667e0f0b86145f68d401e9915b0656ac7ddc7ef7bd81c1058ae9e748a11f045c4780fc76d18e8f73784e9297ce6ad357da8d55925a93a29883e5')

package() {
  local cert_tag='icp_br'
  cd ${srcdir}
  find * -print0 | while read -d $'\0' cert; do
    #some certificates have a .crt extension but come in DER format.
    #convert them
    if [[ "$(file $cert | cut -f2 -d\: | tr -d ' ')" = "data" ]]; then
      msg2 "converting $cert from DER to PEM..."
      cert_der="${cert}.der"
      mv $cert $cert_der
      /usr/bin/openssl x509 -in ${cert_der} -inform der -out $cert
      rm "$cert_der"
    fi
    #some of the cert files have spaces in their names, so just remove the spaces
    #when 'tagging' the certificates
    mv "$cert" "${cert_tag}.${cert//' '/'_'}"
  done
  install -d -m0755 $pkgdir/etc/ca-certificates/trust-source/anchors
  install -m0644 *.crt $pkgdir/etc/ca-certificates/trust-source/anchors
}
