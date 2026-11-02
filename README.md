# gotenberg-de

[Gotenberg](https://gotenberg.dev) mit deutschen Locales und deutschen LibreOffice-Sprachpaketen. Erzeugt die PDF-Berichte von my8data.

## Betrieb

- Image: `ghcr.io/rolandschnurr/gotenberg-de` (privat)
- Läuft als Coolify-Dienst auf dem my8data-Server, nur im internen Docker-Netz erreichbar.
- my8data spricht den Dienst über `GOTENBERG_URL=http://gotenberg-ggo088o4o4owo0wcogsc00w0:3000` mit Basic Auth an.

## Aktualisieren

1. Gotenberg-Version im `Dockerfile` anheben.
2. Auf dem my8data-Server bauen und hochladen (dort ist die ghcr-Anmeldung hinterlegt):

   ```bash
   docker build -t ghcr.io/rolandschnurr/gotenberg-de:<version> -t ghcr.io/rolandschnurr/gotenberg-de:latest .
   docker push ghcr.io/rolandschnurr/gotenberg-de:<version>
   docker push ghcr.io/rolandschnurr/gotenberg-de:latest
   ```

3. Vorher prüfen: HTML-Bericht und Excel-Bericht mit altem und neuem Image wandeln und vergleichen.
4. Dienst in Coolify neu starten.

## Verlauf

| Datum | Gotenberg | Anlass |
|---|---|---|
| 30.09.2025 | 8.23.0 | erste Version (Chromium 139, LibreOffice 25.2) |
| 02.11.2026 | 8.39.0 | Sicherheitsupdate: 9 ausgenutzte Chromium-Lücken (CISA KEV), Brotli CVE-2026-111497 |
