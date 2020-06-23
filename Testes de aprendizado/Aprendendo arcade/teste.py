"""Comentários:
Neste arquivo utilizei para treinar os conceitos básicos de abrir a janela e criar algumas formas

Feito por: Daniel Krüger
"""
# Importando a biblioteca arcade
import arcade

# Definindo constantes da janela
SCREEN_WIDTH = 1200
SCREEN_HEIGHT = 800
SCREEN_TITLE = "Aprendendo"

class Janela(arcade.Window):

    def __init__(self):

        # Abrindo uma Janela
        super().__init__(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE)

        # Colocando uma cor de fundo
        arcade.set_background_color(arcade.color.WHITE)

    def on_draw(self):

        # Começando a renderizar as formas
        arcade.start_render()

        # Realizando as formas
        # Circulo
        arcade.draw_circle_filled(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, 50, arcade.color.BRIGHT_CERULEAN)

        # Linha
        arcade.draw_line(200, 400, 400, 400, arcade.color.BLUE_GRAY, 6)

        # Retângulo
        arcade.draw_lrtb_rectangle_filled(200, 500, 700, 500, arcade.color.BOSTON_UNIVERSITY_RED)

        # Parábola
        arcade.draw_parabola_outline(700, 200, 900, 100, arcade.color.BRONZE, 10)

        # Arco
        arcade.draw_arc_filled(800, 600, 100, 50, arcade.color.BYZANTIUM, 180, 380)

        # Elipse
        arcade.draw_ellipse_filled(300, 200, 300, 200, arcade.color.COFFEE)

        # Quadrado?
        arcade.draw_point(900, 200, arcade.color.BUD_GREEN, 100)

        # Retângulos
        arcade.draw_lrtb_rectangle_filled(200, 500, 700, 500, arcade.color.BOSTON_UNIVERSITY_RED)

        arcade.draw_rectangle_filled(700, 700, 200, 100, arcade.color.COLUMBIA_BLUE)

        arcade.draw_xywh_rectangle_filled(900, 600, 200, 150, arcade.color.DARK_SEA_GREEN)

        """Não necessita escrever
        arcade.finish_render()
        Porque o arcade finaliza automaticamente a renderização
        """

if __name__ == "__main__":
    game = Janela()
    arcade.run()