# Almacen de Jingles

## Herramientas

- direnv
- docker
- nix
- ihp

## Creación de imagen Docker

Para crear una imagen se deben correr los comandos:

```
nix build .#unoptimized-docker-image --option sandbox false --extra-experimental-features nix-command --extra-experimental-features flakes

cat result | docker load
```


# Compilación de Scripts

Para compilar el script que inicializa al usuario administrador:

```
make build/bin/Script/InitializeApp
```

