#!/bin/bash
#   +---------------------------------------+
#   |        PROGRAMA DE GESTION            |
#   |       DE SISTEMA Y PAQUETES           |
#   +---------------------------------------+
#
#   +---------------------------------------+
#   | creado por diego macias de dmaciasblog|
#   +---------------------------------------+




function menu_principal {
    clear
    sleep 1
    echo
    echo
    echo -e "\tGESTION DEL SISTEMA"
    echo
    echo
    echo -e "\t\t${amarillo}1.\t${verde}ACTUALIZAR EL SISTEMA"
    echo -e "\t\t${amarillo}2.\t${verde}BUSCAR E INSTALAR PAQUETES"
    echo -e "\t\t${amarillo}3.\t${verde}ELIMINAR PAQUETES"
    echo -e "\t\t${amarillo}4.\t${verde}LIMPIAR SISTEMA"
    echo -e "\t\t${amarillo}5.\t${verde}INFORMACION DEL SISTEMA"
    echo -e "\t\t${amarillo}8.\t${verde}FORMATEAR USB"
    echo -e "\t\t${amarillo}9.\t${verde}COPIAS DE SEGURIDAD"
    echo -e "\t\t${amarillo}10.\t${verde}COLORES"
    echo -e "\t\t${amarillo}11.\t${verde}SALIR${normal}"
    echo -n -e "\t\t${amarillo}Escoje una opcion [1-10]: "
    read opcionp
    case $opcionp in
        1)
            actualizar
        ;;
        2)
            busins
        ;;
        3)
            remove
        ;;
        4)
            limpiar
        ;;
        5)
            informacion
        ;;
        10)
            colores
        ;;
        11)
            salir
        ;;
        *)
            echo "Opcion no valida, prueba de nuevo"
            sleep 3
            menu_principal
        ;;
    esac

}
######## FUNCION DE ACTUALIZAR EL Sistema
#########################################
function actualizar {
    clear
    echo
    echo -e "\tActualizando el sistema"
    sudo pacman -Syyu
    sleep 2
    tecla
    menu_principal
}
######## FUNCION BUSCAR E INSTALAR
##################################
function busins {
    clear
    echo
    echo -e "${amarillo}\t\t\tBuscar e instalar paquetes${normal}"
    echo -e "${amarillo}\t1.\t${verde}Buscar un paquete"
    echo -e "${amarillo}\t2.\t${verde}Instalar un paquete"
    echo -e "${amarillo}\t3.\t${verde}Volver${normal}"
    echo
    echo -e "Escoje una opcion [1 - 3]: "
    read opbusins
    case $opbusins in
            1)
                echo
                echo "Teclea el nombre del programa a buscar"
                read paquete
                pacman --color=always -Ss $paquete
                sleep 1
                echo -e "\t${verde}Instalar algun paquete?? [ S/N]${normal}"
                read insono
                case $insono in
                    S)
                        instalar
                        tecla
                        busins
                    ;;
                    s)
                        instalar
                        tecla
                        busins
                    ;;
                    N)
                        tecla
                        busins
                    ;;
                    n)
                        tecla
                        busins
                    ;;
                    *)
                        echo -e "\t${amarillo}Opcion invalida......"
                        sleep 3
                        busins
                    ;;
                esac
            ;;
            2)
                instalar
                tecla
                busins
            ;;
            3)
                menu_principal
            ;;
            *)
                echo -e "\t${amarillo}Opcion invalida......"
                sleep 3
                busins
            ;;
    esac

}
######## FUNCION PARA SALIR DEL PROGRAMA
########################################
function salir {
    echo -e "\t${amarillo}Saliendo........${normal}"
    sleep 2
    clear && exit
}
####### FUNCION PULSE UNA TECLA
###############################
function tecla {
    echo -e "\t${amarillo}Pulsa una tecla para volver...${normal}"
    read foo;
}
###### FUNCION INSTALAR PAQUETE
###############################
function instalar {
    echo
    echo -e "\t${verde}Teclea el paquete a instalar: ${normal}"
    read paq
    sudo pacman -S $paq
    unset paq
}
####### FUNCION LIMPIEZA DEL SISTEMA
####################################
function limpiar {
    clear
    echo
    echo -e "\t${amarillo}1.\t${verde}Limpiar cache pacman"
    echo -e "\t${amarillo}2.\t${verde}Borrar paquetes huerfanos"
    echo -e "\t${amarillo}3.\t${verde}Vaciar papeleras"
    echo -e "\t${amarillo}4.\t${verde}Eliminar archivos temporales"
    echo -e "\t${amarillo}5.\t${verde}Todo automatico"
    echo -e "\t${amarillo}6.\t${verde}Salir"
    echo -n -e "\t\t${amarillo}Escoge una opcion [1 - 6]: ${normal}"
    read limp
    case $limp in
            1)
            clear
            echo -e "\tSe va a limpiar la cache de pacman"
            echo -e "\trecuerda que luego no podras hacer"
            echo -e "\tdowngrade de ningun paquete"
            echo
            echo -n -e "\t${amarillo}Desea continuar [S/N]: ${normal}"
            read sn
            case $sn in
                    S)
                    sudo pacman -Scc
                    tecla
                    limpiar
                    ;;
                    s)
                    sudo pacman -Scc
                    tecla
                    limpiar
                    ;;
                    N)
                    limpiar
                    ;;
                    n)
                    limpiar
                    ;;
            esac
            unset sn
            ;;
            2)
            clear
            echo
            pacman -Qtd
            echo -n -e "${amarillo}Desea eliminar TODOS estos paquetes? [S/N]: ${normal}"
            read sn
            case $sn in
                    S)
                    clear
                    echo
                    sudo pacman -R $(pacman -Qqdt)
                    tecla
                    limpiar
                    ;;
                    s)
                    clear
                    echo
                    sudo pacman -R $(pacman -Qqdt)
                    tecla
                    limpiar
                    ;;
                    N)
                    limpiar
                    ;;
                    n)
                    limpiar
                    ;;
                    *)
                    echo
                    echo -e "${amarillo}Opcion no valida"
                    sleep 1
                    limpiar
                    ;;
            esac
            unset sn
            ;;
            3)
            clear
            echo
            echo -e "${verde}\tSe vaciara su papelera y la del usuraio root"
            echo -n -e "${amarillo}Desea continuar [S/N]: ${normal}"
            read sn
            case $sn in
                    S)
                    sudo rm -rf /home/*/.local/share/Trash/*/**
                    sudo rm -rf /root/.local/share/Trash/*/**
                    echo -e "\t${amarillo}Papeleras borradas${normal}"
                    tecla
                    limpiar
                    ;;
                    s)
                    sudo rm -rf /home/*/.local/share/Trash/*/**
                    sudo rm -rf /root/.local/share/Trash/*/**
                    echo -e "\t${amarillo}Papeleras borradas${normal}"
                    tecla
                    limpiar
                    ;;
                    N)
                    limpiar
                    ;;
                    n)
                    limpiar
                    ;;
            esac
            unset sn
            ;;
            4)
            clear
            echo
            echo -e "\t${verde}Se borraran los archivos temporales"
            rm -rf /tmp/* &> /dev/null
            sleep 1
            tecla
            limpiar
            ;;
            5)
            clear
            echo
            echo -e "\t${verde}Va a limpiar todo el sistema en automatico"
            echo -n -e "\t\t${amarillo}Desea continuar? [S/N]: "
            read sn
            case $sn in
                    S)
                    clear
                    echo -e "\tBorrando cache de pacman"
                    sudo pacman -Scc
                    echo -e "\tBorrando paquetes huerfanos"
                    sudo pacman -R $(pacman -Qqdt)
                    echo -e "\tBorrando papeleras"
                    sudo rm -rf /home/*/.local/share/Trash/*/**
                    sudo rm -rf /root/.local/share/Trash/*/**
                    echo -e "\tBorrando archivos temporales"
                    rm -rf /tmp/* &> /dev/null
                    echo -e "\tTodo borrado con exito.."
                    sleep 1
                    tecla
                    limpiar
                    ;;
                    s)
                    clear
                    echo -e "\tBorrando cache de pacman"
                    sudo pacman -Scc
                    echo
                    echo -e "\t${amarillo}Borrando paquetes huerfanos${normal}"
                    echo
                    sudo pacman -R $(pacman -Qqdt)
                    echo
                    echo -e "\t${amarillo}Borrando papeleras${normal}"
                    echo
                    sudo rm -rf /home/*/.local/share/Trash/*/**
                    sudo rm -rf /root/.local/share/Trash/*/**
                    echo -e "\t${amarillo}Borrando archivos temporales${normal}"
                    rm -rf /tmp/* &> /dev/null
                    echo -e "\t${amarillo}Todo borrado con exito..${normal}"
                    sleep 1
                    tecla
                    limpiar
                    ;;
                    N)
                    limpiar
                    ;;
                    n)
                    limpiar
                    ;;
            esac
            unset sn
            ;;
            6)
            menu_principal
            ;;
            *)
            echo
            echo -e "Opcion no valida..."
            sleep 1
            tecla
            limpiar
            ;;
    esac
}
####### FUNCION ELIMINAR PAQUETE
################################
function remove {
    clear
    echo
    echo -e -n "\t${verde}Teclea el paquete a desinstalar: ${normal}"
    read paq
    if [[ sudo pacman -Qtq $paq != $paq ]]; then
        echo
        echo -e "\t${amarillo}Paquete no encontrado, mira las siguientes sugerencias...${normal}"
        sleep 1
        pacman -Qtd | grep $paq
        echo
        echo -e -n "\t${amarillo}Teclee correctamente el paquete a desinstalar: ${normal}"
        read paq

    fi
}
######## FUNCION COLORES APLICACION
###################################
function colores {
    clear
    echo ""
    echo -e "\tGestion de colores de la aplicacion"
    echo -e "\t1.\tModo color"
    echo -e "\t2.\tModo normal"
    echo
    echo -e -n "\tEscoje una opcion: "
    read color
    case $color in
            1)
            ##### TABLA DE COLORES
                verde="\033[32m"
                amarillo="\033[33m"
                negro="\033[30m"
                normal="\033[0m"
                clear
                echo -e "\tCambiando a modo color"
                sleep 1
                menu_principal
            ;;
            2)
                normal="\033[0m"
                verde="\033[0m"
                amarillo="\033[0m"
                negro="\033[0m"
                clear
                echo -e "\tCambiando a modo normal"
                sleep 1
                menu_principal
            ;;
            *)
                echo -e "Opcion no valida"
                sleep 1
                colores
            ;;
    esac
}
### FUNCION INFORMACION
########################
function informacion {
    clear
    echo
    echo -e "\t${amarillo}1.\t${verde}TOP"
    echo -e "\t${amarillo}2.\t${verde}MEMORIA"
    echo -e "\t${amarillo}3.\t${verde}DISCOS"
    echo -e "\t${amarillo}4.\t${verde}HARDWARE"
    echo -e "\t${amarillo}5.\t${verde}SALIR"
    echo
    echo -e -n "\t\t${amarillo}Escoge una opcion [ 1 - 5 ]: "
    read info
    case $info in
            1)
                ctop=$(pacman -Qtq | grep htop)
                if [[ $ctop == 'htop' ]]; then
                    htop
                    unset ctop
                    informacion
                else
                    echo
                    echo -e "\t${amarillo}No tienes instalado htop"
                    echo -e -n "\t${amarillo}quieres instalarlo? [ S/N ]: "
                    read opcion
                    if [[ $opcion == S || $opcion == s ]]; then
                        sudo pacman -S htop
                        sleep 1
                        htop
                        informacion
                    else
                        top
                        informacion
                    fi
                    exit
                    unset ctop
                fi
            ;;
            2)
                free -m
                tecla
                informacion
            ;;
            3)
                clear
                echo
                dfpy=$(pacman -Qtq | grep pydf)
                if [[ $dfpy == 'pydf' ]]; then
                    pydf -h
                    tecla
                    unset dfpy
                    informacion
                else
                    clear
                    echo
                    echo -e "\t${amarillo}No tienes instalado pydf"
                    echo -e -n "\t${amarillo}quieres instalarlo? [ S/N ]: "
                    read opcion
                    if [[ $opcion == S || $opcion == s ]]; then
                        sudo pacman -S pydf
                        sleep 1
                        clear
                        pydf -h
                        tecla
                        informacion
                    else
                        clear
                        df
                        tecla
                        informacion
                    fi
                fi
            ;;
            4)
                clear
                echo
                hard=$(pacman -Qtq | grep lshw)
                if [[ $hard == 'lshw' ]]; then
                    lshw --short
                    echo -e -n "Quieres ver la version con mas detalle [S/N]: "
                    read op
                    if [[ $op == 'S' || $op == 's' ]]; then
                        sudo lshw -html > /tmp/hw.html && $BROWSER /tmp/hw.html
                    fi
                    unset hard
                    unset op
                    informacion
                else
                    clear
                    echo
                    echo -e "\t${amarillo}No tienes instalado lshw"
                    echo -e -n "\t${amarillo}quieres instalarlo? [ S/N ]: "
                    read opcion
                    if [[ $opcion == S || $opcion == s ]]; then
                        sudo pacman -S lshw
                        sleep 1
                        lshw --short
                        echo -e -n "Quieres ver la version con mas detalle [S/N]: "
                        read op
                        if [[ $op == 'S' || $op == 's' ]]; then
                            sudo lshw -html > /tmp/hw.html && $BROWSER /tmp/hw.html
                        fi
                        unset hard
                        unset op
                        unset opcion
                        informacion

                    fi
                fi
            ;;
            5)
                menu_principal
            ;;
            *)
                clear
                echo
                echo -e "\t${amarillo}Opcion no valida..."
                tecla
                informacion
            ;;
    esac

}

menu_principal
