# GNOME (Vanilla)
``Criado em 19 de novembro de 2022``

O **GNOME** é um ambiente desktop disponível no Arch Linux. Ele segue uma filosofia de visual de aplicados semelhante (mas não é uma cópia, passa longe disso) ao MacOS.

Programas que são oficiais, ou intencionados a se integrarem com ele costumam compartilhar um visual semelhante entre si, que se integra completamente ao GNOME.

Na lista a seguir, listo programas oficias e compatíveis com o GNOME que seguem essa filosofia e que podem ser instalados para uma experiência do GNOME considerada "vanilla", que mantém o visual entre todos (ou quase todos) os programas instalados.

Os programas estão separados entre **Pacman** e **Flathub**. Os listados como **Pacman** precisam ser instalados como pacotes do Arch Linux, via ``sudo pacman -S {nomedopacote}``. Já os **Flathub** são pacotes disponíveis no repositório do Flatpak e, para isso, precisa ser instalado no sistema. Para instalar os pacotes listados aqui como Flatpak, usa-se o comando ``flatpak install flathub {nomedopacote}``. Tanto para o ``pacman -S`` quanto para o ``flatpak install``, basta-se listar os pacotes separados por espaços para instalar vários programas por uma única linha de comando.

O Flatpak pode ser instalado no Arch Linux usando os seguidores comandos. *Se você instalou o Arch Linux usando o [Guia de Instalação do Arch Linux com BTRFS](https://github.com/henriquepicanco/guia-archlinux/blob/main/instalacao-archlinux-btrfs.md), você pode pular esta etapa, pois o Flatpak já está instalado.*

````
sudo pacman -S flatpak
````

Deve-se reiniciar o sistema logo em seguida.

## 1. Obrigatórios

Os considerados "aplicativos obrigatórios" são programas e utilitários, considerados por mim, necessários para a mínima usabilidade do GNOME numa instalação limpa do Arch Linux.

- **GDM** - ``gdm`` [Pacman] - Gerenciador de sessões do GNOME;
- **GNOME Shell** - ``gnome-shell`` [Pacman] - Desktop básico;
- **Control Center** - ``gnome-control-center`` [Pacman] - Aplicativo de configuração do GNOME;
- **Keyring** - ``gnome-keyring`` [Pacman] - Gerenciador de segredos, senhas, chaves e certificados e os torna disponíveis para os outros programas. É um utilitário do sistema e deve ser instalado;
- **Diretórios do Usuário** - ``xdg-user-dirs-gtk`` [Pacman] - Utilitário do sistema que cria as pastas "Documento", "Imagens" e outros na pasta /home e as integra ao sistema;
- **Terminal** - ``gnome-terminal`` [Pacman] - Terminal do GNOME;
    - Se você for um usuário casual que não abre muito o terminal, recomendo instalar no lugar o ``gnome-console`` [Pacman]. Novo aplicativo emulador de terminal do projeto, é uma versão simplificada do terminal;
- **Papéis de Parede** - ``gnome-backgrounds`` [Pacman] - Papéis de parede oficias do GNOME;
- **Arquivos** - ``nautilus`` [Pacman] - Gerenciador de arquivos;
- **Adwaita** - ``gnome-themes-extra`` [Pacman] - O tema padrão do GNOME;
- **Software** - ``gnome-software`` [Pacman] - Loja de aplicativos do GNOME;
    - Deve-se instalar o ``gnome-software-packagekit-plugin`` [Pacman] para que a loja seja capaz de instalar programas dos repositórios do Arch Linux de forma gráfica;
- **File Roller** - ``org.gnome.FileRoller`` [Flathub] - Utilitário de compactação e descompactação;
- **Calculator** - ``org.gnome.Calculator`` [Flatpak] - Calculadora (pois sempre é necessário ter uma calculadora no sistema);
- **Text Editor** - ``org.gnome.TextEditor`` [Flatpak] - Editor de textos simples. Mesmo que se use um editor como o NeoVim ou Visual Studio Code, um editor de textos básicos sempre mostra-se necessário;
- **Web** - ``org.gnome.Epiphany`` [Flatpak] - o navegador oficial do projeto GNOME, feito em WebKit;

## 2. Opcionais úteis

Os programas a seguir não são necessários para o sistema rodar ou para a usabilidade básica do sistema. Porém, podem ser interessantes para o uso cotidiano.

- **Ajuda** - ``yelp`` [Pacman] - Utilitário de ajuda, tem documentação para aprender a usar o GNOME;
- **Ajustes** - ``gnome-tweaks`` [Pacman] - Utilitário que permite uma customização um pouco mais profunda do GNOME, como mudança de fontes do sistema e mais;
- **Monitor do Sistema** - ``gnome-system-monitor`` [Pacman] - Gerenciador de tarefas do GNOME;
- **Simple Scan** - ``simple-scan`` [Pacman] - Utilitário de escaneadora;
- **Discos** - ``gnome-disk-utility`` [Pacman] - Aplicativo para gerenciamento de discos;
- **Geary** - ``org.gnome.Geary`` [Flathub] - App de e-mail;
- **Black Box** - ``com.raggesilver.BlackBox`` [Flathub] - Terminal alternativo para o GNOME, com um belíssimo visual;
- **Cheese** - ``org.gnome.Cheese`` [Flathub] - Utilitário para webcam;
- **Relógios** - ``org.gnome.clocks`` [Flathub] - Aplicativo de relógio que permite ver vários fusos ao mesmo tempo;
- **Visualizador de Fontes** - ``org.gnome.font-viewer`` [Flathub] - Utilitário para manejamento de fontes instaladas no sistema;
- **Visualizador de Imagens** - ``org.gnome.eog`` [Flathub] - Visualizador de imagens nativo do GNOME;
- **Analizador de Uso de Disco** - ``org.gnome.baobab`` [Flathub] - Gerenciamento de disco;
- **Visualizador de Documentos** - ``org.gnome.Evince`` [Flathub] - Visualizador de documentos, como PDFs;
- **Calendário** - ``org.gnome.Calendar`` [Flathub] - Calendário que pode ser sincronizado com o Google Agenda e outros;
- **Temperatura** - ``org.gnome.Weather`` [Flathub] - Previsão do tempo (adiciona um applet de tempo ao relógio do sistema);
- **Conexões** - ``org.gnome.Connections`` [Flathub] - Cliente de conexão remota
- **Caracteres** - ``org.gnome.Characters`` [Flathub] - Mapa de caracteres;
- **Contatos** - ``org.gnome.Contacts`` [Flathub] - Aplicativo de contatos;
- **Extensions Manager** - ``com.mattjakeman.ExtensionManager`` [Flathub] - Gerenciador de extenções;
- **Photos** - ``org.gnome.Photos`` [Flathub] - Organizador de fotos;
- **Logs** - ``org.gnome.Logs`` [Flathub] - Veja registros detalhados do sistema;
- **Music** - ``org.gnome.Music`` [Flathub] - Player de música;
- **Video** - ``.org.nome.Totem`` [Flathub] - Player de vídeo;
- **Podcasts** - ``org.gnome.Podcasts`` [Flathub] - Player de podcasts;
- **Solanum** - ``org.gnome.Solanum`` [Flathub] - Relógio pomodoro;
- **Amberol** - ``io.bassi.Amberol`` [Flathub] - Um player de música simplificado;
- **Boxes** - ``org.gnome.Boxes`` [Flathub] - Virtualizador de sistemas operacionais;
- **Secrets** - ``org.gnome.World.Secrets`` [Flathub] - Gerenciador de senhas compatível com o KeePass v.4;
- **Apostrophe** - ``org.gnome.gitlab.somas.Apostrophe`` [Flathub] - Um editor de markdown;
- **Paper** - ``io.posidon.Paper`` [Flathub] - Outro editor de textos markdown, mas este aqui pode organizar suas anotações como cadernos;
- **Authenticator** - ``com.belmoussaoui.Authenticator`` [Flathub] - Gerador de 2FA;
- **Fragments** - ``de.haeckerfelix.Fragments`` [Flathub] - Cliente Bittorrent;
- **Shortwave** - ``de.haeckerfelix.Shortwave`` [Flathub] - Player de rádios online;
- **Mousai** - ``io.github.seadve.Mousai`` [Flathub] - Identificador de músicas, do desktop ou via microfone;
- **Share Preview** - ``com.rafaelmardojai.SharePreview`` [Flathub] - Testar metadata de páginas em localhost;

## 3. Firefox

O Firefox, nesta lista, é um caso à parte. É possível instalar e usar o Firefox sem problemas com o GNOME, mas por padrão, o seu visual não é compatível com o GNOME.

Entretanto, é possível personalizar o Firefox ao ponto de fazê-lo parecer um programa nativo do projeto GNOME. Para fazer isso, instale o Firefox via Flathub.

- **Firefox** - ``org.mozilla.firefox`` [Flathub] - O navegador Mozilla Firefox;

Depois, é necessário rodar os seguintes comandos. Digite um a um.

````
git clone https://github.com/rafaelmardojai/firefox-gnome-theme && cd firefox-gnome-theme
./scripts/install.sh -f ~/.var/app/org.mozilla.firefox/.mozilla/firefox
````

Depois de instalado, o Mozilla Firefox deverá parecer um programa nativo do sistema.