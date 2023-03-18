#!/bin/bash
# Add this line to your .bashrc or a shell script.
source "$HOME/.cache/wal/colors.sh"

ajuda(){
    saida=$1
    echo "Use:
        $0 -e ou -d
    -e  --esquerda      Coloca o conky do lado esquerdo do monitor
    -d  --esquerda      Coloca o conky do lado direito do monitor
    -h  --help          Exibe este texto
    "
    exit ${saida:-1}
}

inverteCor(){
    # Get the input hex color (CHATGPT)
    input_color="$1"

    # Remove the "#" character from the input color
    input_color="${input_color#"#"}"

    # Split the input color into its RGB components
    r="${input_color:0:2}"
    g="${input_color:2:2}"
    b="${input_color:4:2}"

    # Convert the RGB components to decimal values
    r_dec=$((16#${r}))
    g_dec=$((16#${g}))
    b_dec=$((16#${b}))

    # Invert the RGB values
    r_inv=$((255 - ${r_dec}))
    g_inv=$((255 - ${g_dec}))
    b_inv=$((255 - ${b_dec}))

    # Convert the inverted RGB values to hex format
    r_hex=$(printf "%02x" ${r_inv})
    g_hex=$(printf "%02x" ${g_inv})
    b_hex=$(printf "%02x" ${b_inv})

    # Combine the inverted RGB values into a single hex color string
    inverted_color="#${r_hex}${g_hex}${b_hex}"

    # Print the inverted hex color
    echo "${inverted_color}"
}

mudaLado(){
    if [ "$1" = "d" ]
    then
      sed -i -e "/alignment/s/'[^']*'/'bottom_right'/" ./conky.conf
    elif [ "$1" = "e" ]
    then
      sed -i -e "/alignment/s/'[^']*'/'bottom_left'/" ./conky.conf
    fi
}


# CODIGO MAIN


# Cores originais do pywal
AC_o=$(printf "%s\n" "$color1")
BG_o=$(printf "%s\n" "$background")
FG_o=$(printf "%s\n" "$foreground")

# Cores Invertidas 
AC=$(inverteCor $AC_o)
BG=$(inverteCor $BG_o)
FG=$(inverteCor $FG_o)


CL=$(echo "0x${BG##\#}")

sed -i -e "/color1/s/'[^']*'/'${FG_o}'/" ./conky.conf
sed -i -e "/color2/s/'[^']*'/'${FG_o}'/" ./conky.conf
sed -i -e "s/\(destaque\ =\ \)\(.*\)/\1"${CL}"/g" ./conky.lua

case "$1" in
    -e | --esquerda ) mudaLado e ;;
    -d | --direita  ) mudaLado d  ;;
    -h | --help     ) ajuda 0 ;;
    *               ) ajuda ;;
esac


killall conky

sleep 2

/usr/bin/conky -c ./conky.conf > conkylog.log 2>&1 & 