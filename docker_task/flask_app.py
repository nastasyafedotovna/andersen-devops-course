from flask import Flask, request
import emoji
import os
from string import Template


HTML_TEMPLATE = Template("""
<!DOCTYPE html>
<head>
   <title>Docker task</title>
   <style>
      body{
          text-align: center;
          background-color: #FFAAAA;
      }

      iframe{
          width: 80%;
          height: 600px;
          -webkit-animation: fun-function 2.5s linear infinite;
          -webkit-animation-direction: alternate;
          -moz-animation: fun-function 2.5s linear infinite;
          -moz-animation-direction: alternate;
      }

      @-webkit-keyframes fun-function{
        from{
          -webkit-transform: rotate(0deg) skew(-30deg);
        }
        to{
          -webkit-transform: rotate(360deg) skew(30deg);
        }
      }

      @-moz-keyframes fun-function{
        from{
          -moz-transform: rotate(0deg) skew(-30deg);
        }
        to{
          -moz-transform: rotate(360deg) skew(30deg);
        }
      }
   </style>
</head>
<body>
    <h2>${headline}</h2>
    <iframe src="https://www.youtube.com/embed/${youtube_id}?autoplay=1" frameborder="0" allowfullscreen></iframe>
</body>""")


app = Flask(__name__)




@app.route('/', methods=['GET', 'POST'])
def main():
    if request.method == 'POST':
        request_data = request.get_json(force=True)

        animal = None
        sound = None
        count = None

        if request_data:
            if 'animal' in request_data:
                try:
                    animal = emoji.emojize(":"+request_data['animal']+":")
                except:
                    animal = request_data['animal']

            if 'sound' in request_data:
                sound = request_data['sound']

            if 'count' in request_data:
                count = request_data['count']

            if type(count) == type(5):
                out = '{} says {}\n'.format(animal, sound)*count + \
                emoji.emojize('Made with :heart: by Gizar Zigangirov\n', use_aliases=True)
            else:
                out = '{} says {}\n'.format(animal, sound) + \
                emoji.emojize('Made with :heart: by Gizar Zigangirov\n', use_aliases=True)

        else:

            out = 'If you stare into the abyss, the abyss stares back at you'

        return out

    head = """Docker task by Gizar Zigangirov"""
    return HTML_TEMPLATE.substitute(headline=head, youtube_id='oe6b5tMMw1k')

if __name__=="__main__":
    app.run(host = '0.0.0.0',port='8080')
