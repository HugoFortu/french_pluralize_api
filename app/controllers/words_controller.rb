class WordsController < ActionController::API
  EXCEPTIONS = {  pneu: "pneus",
                  landau: "landaus",
                  bleu: "bleus",
                  festival: "festvals",
                  chacal: "chacals",
                  bal: "bals",
                  carnaval: "carnavals",
                  récital: "récitals",
                  corail: "coraux",
                  travail: "travaux",
                  soupirail: "soupiraux",
                  ail: "aulx",
                  vantail: "vantaux",
                  vitrail: "vitraux",
                  bail: "baux",
                  bijou: "bijoux",
                  chou: "choux",
                  genou: "genoux",
                  caillou: "cailloux",
                  hibou: "hiboux",
                  joujou: "joujoux",
                  pou: "poux"
                }

  AL_EXCEPTIONS = %w(acétal ammonal aval bal banal bancal fatal fractal morfal naval aéronaval natal anténatal néonatal périnatal postnatal prénatal tonal atonal bitonal polytonal barbital cal captal carnaval cérémonial chacal chloral chrysocal copal dial dispersal éthanal festival foiral furfural futal gal galgal gardénal graal joual kraal kursaal matorral mescal mezcal méthanal minerval mistral nopal pal pascal (hectopascal kilopascal) penthotal phénobarbital pipéronal raval récital régal rétinal rital roberval roseval salicional sal sandal santal saroual sial sisal sonal tagal tefal tergal thiopental tical tincal véronal zicral corral deal goal autogoal revival serial spiritual trial caracal chacal gavial gayal narval quetzal rorqual serval metical rial riyal ryal cantal emmental emmenthal floréal germinal prairial)
  AU_EXCEPTIONS = %w(antitau berimbau burgau crau donau grau hessiau jautereau jotterau karbau kérabau landau restau sarrau saun gau senau tamarau tau uchau unau wau beu bisteu bleu émeu enfeu eu lieu neuneu pneu rebeu)
  def home
    render json: {
      message: 'welcome',
      endpoints: [
        'https://french-pluralize-api.herokuapp.com/:word',
      ],
    }
  end

  def query
    word = params[:word].downcase

    if EXCEPTIONS.has_key?(word.to_sym)
      response = { plural: EXCEPTIONS[word.to_sym] }
    elsif word[-1] == "x" || word[-1] == "z" || word[-1] == "s"
      response = { plural: word }
    elsif (last_letters(word) == "au" || last_letters(word) == "eu" || last_letters(word) == "eau") && !AU_EXCEPTIONS.include?(word)
      response = { plural: word + "x" }
    elsif last_letters(word) == "al" && !AL_EXCEPTIONS.include?(word)
      response = { plural:  word.chop + "ux" }
    else
      response = { plural: word + "s" }
    end
    render json: response
  end

  def redirect
    redirect_to root_path
  end

  private

  def last_letters(word)
    if word.split('').last(3).join('') == "eau"
      return "eau"
    else
      return word.split('').last(2).join('')
    end
  end
end
