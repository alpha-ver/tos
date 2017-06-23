module Tos

  PARAMS = {

    ###########################
    ### http://tparser.org/ ###
    ###########################

    tparser:{ #class Tparser
      api: {
        1  => {
          key:      :megashara,
          name:     'Megashara',
          homepage: 'http://megashara.com/',
          url:      'http://js1.tparser.org/js1/1.tor.php',
          magnet:   true
        },

        2  =>  {
          key:      :rutor,
          name:     'Rutor',
          homepage: 'http://rutor.org/',
          url:      'http://js1.tparser.org/js1/2.tor.php',
          magnet:   true
        },

        6  =>  {
          key:      :rutracker,
          name:     'Rutracker',
          homepage: 'rutracker.org',
          url:      'http://js3.tparser.org/js3/6.tor.php',
          magnet:   true
        },

        8  => {
          key:      :piratebay,
          name:     'Piratebay',
          homepage: 'http://piratebay.host/',
          url:      'http://js4.tparser.org/js4/8.tor.php',
          magnet:   true
        },

        9  =>  {
          key:      :underverse,
          name:     'Underverse',
          homepage: 'http://underverse.su/',
          url:      'http://js5.tparser.org/js5/9.tor.php',
          magnet:   true
        },

        10 => {
          key:      :kinnozal,
          name:     'Kinozal',
          homepage: 'http://kinozal.tv/',
          url:      'http://js5.tparser.org/js5/10.tor.php',
          magnet:   false
        },

        12 =>  {
          key:      :bitsnoop,
          name:     'Bitsnoop',
          homepage: 'http://bitsnoop.co/',
          url:      'http://js6.tparser.org/js6/12.tor.php',
          magnet:   true
        },
      },

      api_enabled: [1,2,6,8,9,10,12],
      exclude:[],
      include:[],

      params: {
        callback: 'one',
        s:        1,
      },
      query: :jsonpx,

      magnet:{
        url: 'http://tparser.org/magnet.php',
        query: :t
      },

      file_types: {
        1 => :video,
        2 => :audio,
        3 => :other,
        4 => :pdf
      }
    }
  }


end
