Dette er en samling af kantinens skilte og en skilteskabelon. Redigér et
eksisterende skilt, eller lav et nyt i et passende underkatalog, og brug
weave.sh til at smoke dit kantineskilt.

## Brug

Skiltet udformes af pakken `skiltefabrikken`. Pakken vil uden argumenter
udforme skiltet i portræt format med dansk hoved og fod. Du kan dog angive
argumentet `landscape` hvis du ønser et skilt i vandret format. Ligeledes kan
du angive `english` eller `multi` hvis du ønsker engelsk eller standard
tværsproget hoved og fod.

Det er ikke nok at importere pakken. Du skal både bruge kommandoerne
`\maketitle` og `\underskriv` hvis du ønsker hoved og fod. Du kan angive en
titel til hovedet ved at bruge kommandoen `\hovedoverskrift` før kommandoen
`\maketitle`.

Her er et par eksempler:

    \documentclass{article}
    \usepackage{skiltefabrikken}
      \begin{document}
      \hovedoverskrift{Bemærkelsesværdig skilt}
      \maketitle
      \begin{center}
      Kantinen er åben 24/7/365!
      \end{center}
      \underskriv
    \end{document}

    \documentclass{article}
    \usepackage[english,landscape]{skiltefabrikken}
      \begin{document}
      \hovedoverskrift{A very important sign}
      \maketitle
      \begin{center}
      The canteen is open 24/7/365!
      \end{center}
      \underskriv
    \end{document}

## Licens

Copyright (c) 2013 Datalogisk Kantineforening.
Licenseret under EUPL, version 1.1 udelukkende.
Licensteksten: https://joinup.ec.europa.eu/software/page/eupl/licence-eupl

## Kodestil

Dokumentation og kommentarer skrives på dansk for hyggens skyld. Variabelnavne,
filnavne, og andet er på engelsk for ikke at forstyrre de ellers engelske
nøgleord og konventioner.
