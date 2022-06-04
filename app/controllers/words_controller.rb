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
    elsif last_letters(word) == "au" || last_letters(word) == "eu" || last_letters(word) == "eau"
      response = { plural: word + "x" }
    elsif last_letters(word) == "al"
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
