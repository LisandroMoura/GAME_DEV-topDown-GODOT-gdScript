# tutorial
-----
https://www.youtube.com/watch?v=BmJlBFUVBDo&list=PLFzAtSiFUbT-UZcEli_IlKFQdk3FEBMlq&ab_channel=DevBandeira


# Assets usado
https://game-endeavor.itch.io/mystic-woods
	padrão de 16px

# configurações de projeto:
	- Janela (bom tamanho para a arte de 16px)
		- 320
		- 180
	- advanced -> substituição:
		- 320 * 4
		- 180 * 4
	- Textura
		- filtro nearest
	- Layer name 
		- phisic 2d
		 - world
		 - player
		 - enemys
		 - platforms
		 - collectibles
		
	Scenes 
	- menu
	- level
	
	prefabs
	- character
	- enemy 
			


@export_flags("Fire", "Water", "Earth", "Wind") var spell_elements = 0

	@export_group(name: String, prefix: String = "")
