# Quake log parser

## Task 1

Construa um parser para o arquivo de log games.log.

O arquivo games.log é gerado pelo servidor de quake 3 arena. Ele registra todas as informações dos jogos, quando um jogo começa, quando termina, quem matou quem, quem morreu pq caiu no vazio, quem morreu machucado, entre outros.

O parser deve ser capaz de ler o arquivo, agrupar os dados de cada jogo, e em cada jogo deve coletar as informações de morte.

### Exemplo

  	21:42 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT
  
  O player "Isgalamido" morreu pois estava ferido e caiu de uma altura que o matou.

  	2:22 Kill: 3 2 10: Isgalamido killed Dono da Bola by MOD_RAILGUN
  
  O player "Isgalamido" matou o player Dono da Bola usando a arma Railgun.
  
Para cada jogo o parser deve gerar algo como:

    game_1: {
	    total_kills: 45;
	    players: ["Dono da bola", "Isgalamido", "Zeh"]
	    kills: {
	      "Dono da bola": 5,
	      "Isgalamido": 18,
	      "Zeh": 20
	    }
	  }

### Observações

1. Quando o `<world>` mata o player ele perde -1 kill.
2. `<world>` não é um player e não deve aparecer na lista de players e nem no dicionário de kills.
3. `total_kills` são os kills dos games, isso inclui mortes do `<world>`.

## Task 2

Após construir o parser construa um script que imprima um relatório de cada jogo (simplemente imprimindo o hash) e um ranking geral de kills por jogador.

## Task 3

Gerar um relatório de mortes agrupando pelo motivo da morte, por partida.

Causas de morte (retirado do [código fonte](https://github.com/id-Software/Quake-III-Arena/blob/master/code/game/bg_public.h))

	// means of death
	typedef enum {
		MOD_UNKNOWN,
		MOD_SHOTGUN,
		MOD_GAUNTLET,
		MOD_MACHINEGUN,
		MOD_GRENADE,
		MOD_GRENADE_SPLASH,
		MOD_ROCKET,
		MOD_ROCKET_SPLASH,
		MOD_PLASMA,
		MOD_PLASMA_SPLASH,
		MOD_RAILGUN,
		MOD_LIGHTNING,
		MOD_BFG,
		MOD_BFG_SPLASH,
		MOD_WATER,
		MOD_SLIME,
		MOD_LAVA,
		MOD_CRUSH,
		MOD_TELEFRAG,
		MOD_FALLING,
		MOD_SUICIDE,
		MOD_TARGET_LASER,
		MOD_TRIGGER_HURT,
	#ifdef MISSIONPACK
		MOD_NAIL,
		MOD_CHAINGUN,
		MOD_PROXIMITY_MINE,
		MOD_KAMIKAZE,
		MOD_JUICED,
	#endif
		MOD_GRAPPLE
	} meansOfDeath_t;

Exemplo:

	"game-1": {
		kills_by_means: {
			"MOD_SHOTGUN": 10,
			"MOD_RAILGUN": 2,
			"MOD_GAUNTLET": 1,
			"XXXX": N
		}
	}

## Task 4

Considerando o log dado, assuma as seguinte regras:

* Os itens são cumulativos, mas cada ítem é registrado em uma entrada específica. Ou seja, quando um player pega 3 unidades do mesmo ítem, o log apresentará 3 registros seguidos do mesmo ítem para o mesmo player.
* Cada ítem desaparece em 3 minutos!
* Ao matar, o player que morre transfere todos os seus ítens para quem o matou.

Escreva o seguinte report:

* Para cada final de jogo, qual inventário cada jogador possui?

# Requisitos

1. crie um repositório privado do GitHub ou Gitlab para conter sua solução
2. para cada task, crie uma PR separada. Para facilitar o review, você pode fazer com que as PRs se mergeiem de forma progressiva (por exemplo, a PR da task 1 mergeia na branch main -> a PR da task 2 mergeia na branch da task 1, ...), no Github isso é feito na hora de abrir a PR: ![image](https://user-images.githubusercontent.com/4325587/212912264-44d6a26e-a3b3-43e0-b38f-171c21067645.png)
3. sempre que possível, adicione testes
4. não se esqueça de criar arquivos como .gitignore e relacionados


HAVE FUN :)
