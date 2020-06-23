"""Comentários:
Neste arquivo utilizei para testar como renderizar o jogador  e os inimigos, 
além de fazer os inimigos serem gerados randomicamente, os inimigos eram para serem eliminados
quando o personagem encostase neles eles seriam eliminados,
contudo não consegui checar se está funcionando, pois
ainda estou tentando aprender a realizar a movimentação do personagem.

Feito por: Daniel Krüger
"""

import arcade
import random

# Constantes
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
SCREEN_TITLE = "Testes"

# Constantes das Sprites
ENEMY_CHARACTER_SCALING = 0.085
PLAYER_CHARACTER_SCALING = 0.095

class MyGame(arcade.Window):
    
    # Abrindo uma janela
    def __init__(self):
        super().__init__(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE)

        # Aplicando cor ao fundo
        arcade.set_background_color(arcade.color.WHITE)

        # Listas das Sprites
        self.player_list = None
        self.enemy_list = None

        # Criando uma variável vazia, que futuramente será a Sprite do player
        self.player_sprite = None

    def setup(self):
        # Criando uma lista de sprites
        self.player_list = arcade.SpriteList()
        self.enemy_list = arcade.SpriteList()

        # Adicionando informações ao personagem
        self.player_sprite = arcade.Sprite("Joga.png", PLAYER_CHARACTER_SCALING) # Definindo a Sprite
        self.player_sprite.center_x = SCREEN_WIDTH / 2 # Definindo sua posição na linha x
        self.player_sprite.center_y = SCREEN_HEIGHT / 2 # Defininfo sua posição na linha y
        self.player_list.append(self.player_sprite) # Adicionando a Sprite a uma lista

        # Criando randomicamente inimigos
        for i in range(10):
            
            # Criando um inimigo
            enemy = arcade.Sprite("SpriteInimigo.png", ENEMY_CHARACTER_SCALING)

            # Posição do inimigo
            enemy.center_x = random.randrange(SCREEN_WIDTH)
            enemy.center_y = random.randrange(SCREEN_HEIGHT)

            # Adicionado a lista
            self.enemy_list.append(enemy)

    def on_draw(self):
        # Començando a renderizar
        arcade.start_render()

        # Reiderizando os personagens
        self.enemy_list.draw()
        self.player_list.draw()

    def update(self, delta_time):
        # Gerando uma lista de todos os inimigos que colidiram com o player
        enemy_hit_list = arcade.check_for_collision_with_list(self.player_sprite, self.enemy_list)

        # Se o player colidir com os inimigos, eles seram eliminados
        for enemy in enemy_hit_list:
            enemy.kill()

# Iniciando o código
def main():
    game = MyGame()
    game.setup()
    arcade.run()

# Checando se este é o arquivo principal
if __name__ == "__main__":
    main()