# Guia de Instalação do Arch Linux com BTRFS
``Criado em 19 de novembro de 2022``

Bem-vindo ao Guia de Instalação manual do **Arch Linux**, customizado por [@henriquepicanco](https://mastodon.social/henriquepicanco). Este guia foi baseado nas instruções contidas na Wiki do Arch Linux, disponível [neste link](https://wiki.archlinux.org/title/Installation_guide).

Este guia foi adaptado para meu uso. Ele pode ser usado por você, sem problema algum, mas deve-se salientar que meus passos, ou os pacotes que uso, podem não ser interessantes para a SUA instalação. Recomenda-se fazer uma comparação com o artigo contido na *wiki*, e adaptar o conteúdo a seguir para as suas necessidades.

Este guia assumirá que você já tem uma ISO do Arch Linux queimada em um pendrive e que você já tem algum conhecimento sobre editores de texto VIM, NeoVim ou Nano, e sobre o comando SUDO. Este guia instalá apenas o sistema base, sem ambiente gráfico.

## 1. Antes de começar

- Certifique-se que de o **Secure Boot está desativado**;
- De que há espaço separado e disponível para a instalação do Arch Linux (no mínimo, 50 GB);

## 2. Primeiros passos

- Primeiramente, configura-se o teclado. No meu caso, o layout de teclado é o ``us-acentos``:

    ````
    loadkeys us-acentos
    ````

- É necessário checar se há conexão com a internet. Para isso, roda-se:

    ````
    ping archlinux.org -c 4
    ````

- Depois de certificado que há internet, configura-se a hora do computador:

    ````
    timedatectl set-ntp true
    timedatectl status
    ````

## 3. Particionamento

- Depois de configurado tudo, faz-se o particionamento do disco. O meu computador (e este guia) assume que você tem instalado o Windows em outra partição;
- O particionamento de 50 GB recomendado para o Arch Linux é:
    - 8 GB para *swap*;
    - 42 GB para /root;
- Para fazer o particionamento de forma fácil, usa-se o ``cfdisk``:

    ````
    cfdisk
    ````

- Certifique-se de anotar o número das partições criadas;
    - No Arch Linux, quando em um HDD ou SSD Sata, as partições começam com **/dev/sdX**, sendo X o número da partição;
- Após configuradas as partições, necessita-se formatar os discos. Numa instalação normal, formata-se as partições de **/root**, além do Swap.
- Neste guia, assumirei que há três partições: ``efi``, ``root`` e ``swap``. Aqui, serão o seguinte:
    - ``/dev/sdX`` será a partição ``EFI`` (troque "X" pelo número correspondente);
    - ``/dev/sdY`` será a partição ``root`` (troque "Y" pelo número correspondente);
    - ``/dev/sdZ`` será a partição ``swap`` (troque "Z" pelo número correspondente);
- Agora que fizemos a partição do disco, podemos continuar com a formatação;
- Formatemos as partições ``root`` e ``swap``:

    ````
    mkfs.btrfs /dev/sdY
    mkswap /dev/sdZ
    ````

- Num dual-boot com o Windows, a partição do bootloader já deverá existir e não deve ser formatada. Se, na sua instalação, a partição EFI não existir (o disco está livre e o Arch será o único sitema instalado), uma partição EFI será necessária. Leia a **wiki** do Arch Linux para maiores informações;
- Se não houver uma partição EFI e você criou uma partição para ela em ``cfdisk``, deverá ser formada com o seguinte comando:
    
    ````
    mkfs.fat -F 32 /dev/sdX
    ````

## 4. Montagem

- Após a formatação dos discos, precisa-se montar os pontos;
- Primeiro, montemos a partição /root e a preparamos para a instalação do sistema;
- Como formatamos com BTRFS, esta tecnologia exige algumas coisas antes de começarmos;
- Essa tecnologia permite fazer snapshots do sistema e poder voltar a pontos pré-determinados:

    ````
    mount /dev/sdY /mnt
    btrfs su cr /mnt/@
    btrfs su cr /mnt/@home
    btrfs su cr /mnt/@var
    btrfs su cr /mnt/@opt
    btrfs su cr /mnt/@tmp
    btrfs su cr /mnt/@.snapshots
    umount /mnt
    ````

- Depois, é preciso criar as pastas do sistema;
- Por conta da tecnologia, precisamos fazer isso uma a uma, com os seguites comandos:

    ````
    mount -o noatime,commit=120,compress=zstd,space_cache,subvol=0 /dev/sdY /mnt
    mkdir /mnt/{efi,home,var,opt,tmp,.snapshots}
    mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@home /dev/sdY /mnt/home
    mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@opt /dev/sdY /mnt/var
    mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@opt /dev/sdY /mnt/opt
    mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@tmp /dev/sdY /mnt/tmp
    mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@.snapshots /dev/sdY /mnt/.snapshots
    mount -o subvol=@var /dev/sdY /mnt/var
    ````

- E, por último, é necessário montar a partição EFI;
- Num dual-boot com o Windows, esta partição já foi criada pelo instalador do Windows e não deve ser formatada!
- Numa instalação onde o Arch Linux será o único sistema, ela foi criada no passo 3:

    ````
    mount /dev/sdX /mnt/efi
    ````

- Por último, a partição **SWAP**, formantando e montando a partição:

    ````
    swapon /dev/sdY
    ````

## 5. Sitema-base

- Agora, é necessário instalar os pacotes-base do sistema;
- O pacstrap instala o sistema base e mais alguns pacotes para o sistema;
- Troque o ``neovim`` pelo ``nano``, se essa for sua preferência para editor de texto em linha de comando;
- Para gerenciar a conexão com a internet, usarei o ``NetworkManager``, troque por outro ou adicione pacotes adicionais, dependendo do seu caso;
- Para iniciar o sistema, instalaremos o GRUB. O ``efibootmgr`` é um utilitário para manejarmos o EFI, ``intel-ucode`` é um pacote interessante apenas para computadores em INTEL;
- Já o ``ntfs-3g`` e o ``os-prober`` são específicos para que o sistema consiga ver a partição do Windows e que o GRUB consiga ver a partição do sistema da Microsoft durante a sua auto-configuração:

    ````
    pacstrap -K /mnt linux linux-firmware base neovim intel-ucode btrfs-progs git sudo networkmanager grub efibootmgr ntfs-3g os-prober 
    ````

- Gera-se um arquivo Fstab logo na sequencia:

    ````
    genfstab -U /mnt >> /mnt/etc/fstab
    ````

## 6. Entrando no sistema instalado

- Agora, é necessário acessar o /root do **sistema instalado**, usando o comando a seguir:

    ````
    arch-chroot /mnt
    ````

- Desde momento em diante, estaremos trabalhando no sistema instalado no computador, e não mais no sistema LIVE do pendrive. Qualquer alteração aqui ficará permanentemente escrito no sistema instalado (há menos que seja corrigido depois, é claro);

## 7. Hora e localização

- Primeiro, define-se o timezone da instalação. No meu caso, é ``America/Sao_Paulo``, mas seu caso pode ser outra localidade:

    ````
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    ````

- Depois, gera-se um ``/etc/adjtime`` com o comando abaixo:

    ````
    hwclock --systohc
    ````

- Depois, descomenta-se a linha relativa ao seu idioma no arquivo ``/etc/locale.gen``:

    ````
    nvim /etc/locale.gen
    ````

- Depois, adiciona-se a linha ``LANG=pt_BR.UTF-8`` ao arquivo ``/etc/locale.conf``:

    ````
    nvim /etc/locale.conf
    ````

- Por último, adiciona-se o keymap relativo ao seu teclado, sendo o meu caso ``KEYMAP=us-acentos``, ao arquivo ``/etc/vconsole.conf``:

    ````
    nvim /etc/vconsole
    ````

## 8. Configuração de rede

- Primeiro, é preciso dar um nome para o seu computador na rede doméstica. Você pode dar qualquer nome, mas atente-se a alguns detalhes;
    - Você pode começar o nome com letra maiúscula, mas não deve ser todo em maiúsculo;
    - Pode conter letras, números e traços, mas nada além disso é recomendável;
    - Não deve começar com um número;
- Depois de escolhido o nome, escreva-o no arquivo ``/etc/hostname``:

    ````
    nvim /etc/hostname
    ````

- Após, é bom configurar o arquivo ``/etc/hosts``:

    ````
    nvim /etc/hosts
    ````

- Neste arquivo, adicione as linhas como estiverem abaixo:

    ````
    127.0.0.1     localhost
    ::1           localhost
    127.0.1.1     [HOSTNAME].localdomain    [HOSTNAME]
    ````

- Acima, troque o ``[HOSTNAME]`` pelo nome que você deu em ``/etc/hostname``. Deve ser o mesmo!
- Por último, ativaremos o gerenciador de conexão à internet;
- Use o comando abaixo:

    ````
    systemctl enable NetworkManager.service
    ````
 
## 9. Contas

- Agora, configuremos a senha de **root** e criaremos um usuário comum para o dia-a-dia, mas com acesso sudo para instalar programas e fazer configurações pontuais;
- Para adicionar uma senha para o root, usa-se o comando abaixo:

    ````
    passwd
    ````

- Depois, cria-se um usuário para uso do dia a dia. Troque [USER] pelo nome de usuário que você quer usar:

    ````
    useradd -m -G wheel -s /bin/bash [USER]
    ````

- Agora, adiciona-se uma senha para este usuário recentemente criado. Escolha uma senha segura e, por segurança, tem que ser uma senha diferente da que foi usada para o usuário root:

    ````
    passwd [USER]
    ````

- Depois, é necessário adicionar o usuário comum criado ao **sudo**;
- Para isso, é necessário descomentar a linha referente ao grupo **wheel** no arquivo ``/etc/sudoers``;
    - No comando para criar o usuário, nós o adicionamos ao grupo wheel;
- Abra o arquivo ``/etc/sudoers`` e procure pela linha ``%wheel ALL=(ALL:ALL) ALL``;
- Para descomentar essa linha, remova o ````#```` do início da linha. Depois, salve e saia do arquivo;
- O arquivo ``/etc/sudoers`` deve ser editado sempre com o comando VISUDO. Ele procurará pelo editor ``vi`` e abrirá o arquivo com segurança;
- Entretanto, como você já deve ter notado, não instalamos o editor ``vi``. Por isso, é necessário editar essa entrada. Antes de propriamente editar o arquivo, mudemos o editor para ``visudo`` e aí sim, editemos o arquivo;
- No comando abaixo, se você usa o ``nano``, troque ``nvim`` por ``nano`` em ``EDITOR=nvim``:

    ````
    EDITOR=nvim visudo 
    ````

## 10. ``mkinitcpio``

- Por conta do BTRFS, precisamos colocar ele aos módulos do ``mkinitcpio``;
- Abra o arquivo de configuração para adicionar ``btrfs`` entre os parêntes de ``MODULES=()``:

    ````
    nvim /etc/mkinitcpio.conf
    ````

- Depois, roda-se o comando abaixo:

    ````
    mkinitcpio -p linux
    ````

## 11. Bootloader

- Agora, é necessário configurarmos o bootloader do sistema. O GRUB já foi instalado;
- Antes de fazer a configuração do GRUB, é preciso editar o arquivo ``/etc/default/grub``. Abra-o e descomente a linha ``GRUB_DISABLE_OS_PROBER=false``;
- Se essa linha não existir, adicione o ``GRUB_DISABLE_OS_PROBER=false`` ao final do arquivo ``/etc/default/grub``:

    ````
    nvim /etc/default/grub
    ````

- Depois, roda-se a configuração do GRUB:

    ````
    grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=Arch --recheck
    grub-mkconfig -o /boot/grub/grub.cfg
    ````

- Nestes comandos acima, o GRUB deverá ser capaz de encontrar e adicionar o Windows a lista de seleção do GRUB ao ligar o computador. Se algo acontecer e o GRUB não encontrar o Windows, é possível que algum problema aconteceu e o GRUB não encontrou a partição. O Windows ainda está instalado, então não se preocupe e procure no Google sobre o que pode ter acontecido e como pode-se contornar a situação;

## 12. Final

- Tudo o que for necessário para o Arch Linux dar boot já foi instalado. Neste momento, pode-se sair o arch-chroot e desmontar os discos;
- Se você tiver criado uma partição /home, adicione ``home,`` (com uma vírgula ao final) dentro dos colchetes no comando ``umount`` abaixo:

    ````
    exit
    umount -l /mnt
    ````

- Agora, pode-se desligar o computador ou apenas reiniciar. Recomendo desligar para poder retirar a mídia de instalação do Arch Linux de forma mais calma:

    ````
    poweroff
    ````

- Se, mesmo assim, você quiser apenas reiniciar ao invés de desligar, rode o seguinte comando:

    ````
    reboot
    ````

- Agora, o sistema está instalado no seu computador, com pacotes básicos para dar boot no Arch Linux;
- Ele, por agora, entrará num sistema em linha de comando. É recomendável pesquisar sobre ambientes gráticos e outras ferramentas;
- O seu sistema instalado terá um usuário criado por você, que pode ser usado logo no primeiro arranque do sistema;
- É possível logar como ``root``, mas não é recomendável;

---

## 13. Snapper

- A maior destaque do BTRFS é a possibilidade de criar *snapshots* do sistema em momentos determinados. Isso pode ser usado para recuperar o sistema para um determinado, tal qual a tecnologia do **Time Machine** existente no MacOS;
- Como tudo até agora foi feito usando a linha de comando, a forma descrita neste guia também usará a linha de comando;
- Neste guia, usarei o **Snapper**, mas há outras formas disso ser feito (recomenda-se pesquisar mais sobre);
- Existem GUIs disponíveis para o Snapper, mas tanto o ``snapper-gui-git`` quanto o ``btrfs-assistant`` só estão disponíveis pelo AUR - e este guia não cobrirá essa parte;
- Instale o pacote do ``snapper`` e o ``grub-btrfs``:

    ````
    pacman -S snapper grub-btrfs
    ````

- Primeiro, vamos chegar os subvolumes do BTRFS:

    ````
    btrfs sub list /
    ````

- O comando acima deverá retornar a seguinte lista:

    ````
    ID 256 gen 810 top level 5 path @
    ID 257 gen 781 top level 5 path @tmp
    ID 258 gen 810 top level 5 path @log
    ID 259 gen 804 top level 5 path @pkg
    ID 260 gen 10 top level 5 path @snapshots
    ID 264 gen 34 top level 256 path var/lib/portables
    ID 265 gen 35 top level 256 path var/lib/machines
    ````

- Agora, criaremos a configuração do ``snapper``:

    ````
    snapper -c root create-config /
    ````

- Precisamos listar novamente os subvolumes do BTRFS:

    ````
    btrfs sub list /
    ````

- As partições BTRFS deverão ser novamente listadas, como o exemplo abaixo:

    ````
    ID 256 gen 810 top level 5 path @
    ID 257 gen 781 top level 5 path @tmp
    ID 258 gen 810 top level 5 path @log
    ID 259 gen 804 top level 5 path @pkg
    ID 260 gen 10 top level 5 path @snapshots
    ID 264 gen 34 top level 256 path var/lib/portables
    ID 265 gen 35 top level 256 path var/lib/machines
    ID 267 gen 87 top level 257 path /.snapshots
    ````

- Note que a pasta ``/.snapshots`` está listada abaixo da pasta ``root``. Isso é um problema, pois o subvolue está abaixo do subvolume referente a ``root``;
- Se você fizer uma restauração com esta configuração, a pasta ``/.snapshot`` irá desaparecer, pois depende do subvolume de ``root``;
- Para corrigir isso, delete o subvolume ``/.snapshots`` e refaça a pasta:

    ````
    btrfs sub del /.snapshots/
    mkdir /.snapshots
    nvim /etc/fstab
    ````

- Será necessário montar o diretório no ``/etc/fstab``;
- Abra o arquivo abaixo e adicione a linha ``/dev/sdY /.snapshots btrfs rw,relatime,compress=lzo,ssd,space_cache=v2,subvol=@snapshots 0 0``:

    ````
    nvim /etc/fstab
    ````

- Então remonte ``/.snapshots``; 
- Cheque se tudo está correto, rodando o comando abaixo:

    ````
    df -Th
    ````

- O retorno do comando acima deverá ser semelhante ao conteúdo abaixo:

    ````
    Filesystem     Type      Size  Used Avail Use% Mounted on
    dev            devtmpfs  3.9G     0  3.9G   0% /dev
    run            tmpfs     3.9G  1.5M  3.9G   1% /run
    /dev/sdY       btrfs      32G  7.4G   25G  24% /
    tmpfs          tmpfs     3.9G   70M  3.8G   2% /dev/shm
    tmpfs          tmpfs     4.0M     0  4.0M   0% /sys/fs/cgroup
    /dev/sdY       btrfs      32G  7.4G   25G  24% /btrfs
    /dev/sdY       btrfs      32G  7.4G   25G  24% /tmp
    /dev/sdY       btrfs      32G  7.4G   25G  24% /var/cache/pacman/pkg
    /dev/sdY       btrfs      32G  7.4G   25G  24% /var/log
    /dev/sdY       vfat      511M  564K  511M   1% /boot/efi
    /dev/sdY       xfs       921G  144G  778G  16% /home
    tmpfs          tmpfs     784M   72K  784M   1% /run/user/1000
    /dev/sdY       btrfs      32G  7.4G   25G  24% /.snapshots
    ````

- Se está tudo certo, podemos continuar;
- Agora, para habilitar que os snapshots possam ser exibidos no GRUB, é necessário habilitar o ``grub-btrfs.path`` com o ``systemctl``:

    ````
    systemctl enable grub-btrfs.path
    ````

- E habilitar a lista de snapshots no GRUB, editando o arquivo abaixo e colocando na última linha ``GRUB_DISABLE_RECOVERY=false``:

    ````
    nvim /etc/default/grub
    ````

- Depois, gere uma nova configuração para o GRUB, com:

    ````
    grub-mkconfig -o /boot/grub/grub.cfg
    ````

---

- Agora, você tem um sistema Arch Linux instalado, com a possibilidade de criar snapshots para salvar o estado do sistema de tempos em tempos;
- Você já poderá ir ao Twitter e tuitar "I use Arch, btw" com sucesso.

Siga-me nas redes sociais! Estou no Twitter, em [@henriquepicanco](https://twitter.com/henriquepicanco) e no Mastodon, em [@henriquepicanco@mastodon.social](https://mastodon.social/henriquepicanco).
