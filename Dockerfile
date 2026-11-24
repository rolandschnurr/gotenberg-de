# Gotenberg für my8data: deutsche Locales und deutsche LibreOffice-Sprachpakete.
# Wird als ghcr.io/rolandschnurr/gotenberg-de veröffentlicht und auf dem my8data-Server
# als Coolify-Dienst betrieben (PDF aus HTML über Chromium, PDF aus Excel über LibreOffice).
#
# Die Gotenberg-Version ist fest eingetragen, damit ein Neubau nicht unbemerkt wechselt.
# 8.40.0 (05.11.2026): letztes Release von Gotenberg 8, Chromium 156.0.8078.79, LibreOffice 26.8.2.
# Gotenberg 9 ist ein Major-Sprung und noch nicht geprüft.
FROM gotenberg/gotenberg:8.40.0

USER root

# Deutsche Locales
RUN apt-get update && \
    apt-get install -y locales && \
    echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen de_DE.UTF-8 && \
    update-locale LANG=de_DE.UTF-8 LC_ALL=de_DE.UTF-8

# Chromium aus trixie-security nachziehen. Gotenberg 8 bekommt kein Release mehr, das
# Basis-Image bleibt also bei Chromium 156.0.8078.79 stehen. Der Neubau bricht ab, wenn
# Debian weniger als die Fassung liefert, die CVE-2026-125350 behebt.
ARG CHROMIUM_MIN=156.0.8078.108
RUN apt-get install -y --only-upgrade chromium chromium-common && \
    dpkg --compare-versions "$(dpkg-query -W -f='${Version}' chromium)" ge "$CHROMIUM_MIN" && \
    dpkg --compare-versions "$(dpkg-query -W -f='${Version}' chromium-common)" ge "$CHROMIUM_MIN"

# Deutsche LibreOffice-Sprachpakete. LibreOffice kommt in Gotenberg 8.3x aus trixie-backports,
# die Sprachpakete müssen aus derselben Quelle stammen, sonst passen die Versionen nicht zusammen.
RUN apt-get install -y -t trixie-backports \
    libreoffice-l10n-de \
    libreoffice-help-de && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER gotenberg

ENV LANG=de_DE.UTF-8
ENV LC_ALL=de_DE.UTF-8
ENV TZ=Europe/Berlin
