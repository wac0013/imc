<!DOCTYPE html>
<%
  double peso = Double.parseDouble((request.getParameter("peso") != null) ? request.getParameter("peso") : "0");
  double altura = Double.parseDouble((request.getParameter("altura") != null) ? request.getParameter("altura") : "0");
  String mensagem = "";

  double imc = (peso / (altura * altura));
  
  if (imc < 16) {
    mensagem = "Magreza grave";
  } else if (16 <= imc && imc < 17) {
    mensagem = "Magreza moderada";
  } else if (17 <= imc && imc < 18.5) {
    mensagem = "Magreza leve";
  } else if (18.5 <= imc && imc < 25) {
    mensagem = "Saldável";
  } else if (25 <= imc && imc < 30) {
    mensagem = "Sobrepeso";
  } else if (30 <= imc && imc < 35) {
    mensagem = "Obesidade Grau I";
  } else if (35 <= imc && imc < 40) {
    mensagem = "Obesidade Grau II (severa)";
  } else {
    mensagem = "Obesidade Grau III (mórbida)";
  }
%>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Calculo IMC</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script
    src="https://code.jquery.com/jquery-3.1.1.min.js"
    integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
    crossorigin="anonymous">
  </script>  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.3.1/dist/semantic.min.css">
  <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.3.1/dist/semantic.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.min.js"></script>
  <style>
    body > .grid {
      height: 100%;
    }
    body {
      background-color: #dadada
    }
  </style>
</head>
<body class="ui container">
  <div class="ui middle aligned grid">
    <div class="row">
    <div class="column">      
      <form id="formulario" class="ui form">
        <div class="ui red raised centered card">
          <div class="content">
            <div class="center aligned header"><h3>Calculadora IMC</h3></div>
          </div>
          <div class="extra content">
            <div class="field required">
              <label>Sexo</label>
              <div class="ui selection dropdown">
                <input type="hidden" id="sexo">
                <i class="dropdown icon"></i>
                <div class="default text">Sexo</div>
                <div class="menu">
                  <div class="item" data-value="M"><i class="mars icon"></i>Masculino</div>
                  <div class="item" data-value="F"><i class="venus icon"></i>Feminino</div>
                </div>
              </div>
            </div>
            <div class="field required">
              <label>Idade</label>
              <div class="ui right labeled input">
                <input type="number" min="0" placeholder="Informe idade.." id="idade">
                <div class="ui basic label">anos</div>
              </div>
            </div>
            <div class="field required">
              <label>Peso</label>
              <div class="ui right labeled input">
                <input type="number" min="0" step="0.01" placeholder="Informe peso.." id="peso">
                <div class="ui basic label">Kg</div>
              </div>
            </div>
            <div class="field required">
              <label>Altura</label> 
              <div class="ui right labeled input">
                <input type="number" min="0" step="0.01" max="2.99" placeholder="Informe altura.." id="altura">
                <div class="ui basic label">m</div>
              </div>
            </div>
          </div>
          <button class="ui bottom attached orange button" onclick="$('#mensagem_erro').modal('show')">Calcular</button>
        </div>
        <div class="ui message" id="mensagem_erro">          
          <div style="text-align: center"><i class="times circle outline huge icon"></i></div>
          <div class="ui error message"></div>          
        </div>   
      </form>
      <div class="ui modal message" style="text-align: center" id="resultado">
          <p>
            <%
              out.println(" Seu Índice de Massa Corpórea (IMC) é " + imc + "\n" + mensagem);
            %>
          </p> 
        </div>
      </div>
    </div>
    <div class="row">
      <div class="column">
          <table class="ui red two column unstackable celled table">
            <thead>
              <tr>
                <th class="">IMC</th>
                <th>Situação</th>
              </tr>
            </thead>
            <tbody>
              <tr class="error">
                <td>< 16</td><td>Magreza</td>
              </tr>
              <tr class="error">
                <td>16 a < 17</td><td>Magreza moderada</td>
              </tr>
              <tr class="warning">
                <td>17 a < 18,5</td><td>Magreza leve</td>
              </tr>
              <tr class="positive">
                <td>18,5 a < 25</td><td>Saudável</td>
              </tr>
              <tr class="warning">
                <td>25 a < 30</td><td>Sobrepeso</td>
              </tr>
              <tr class="warning">
                <td>30 a < 35</td><td>Obesidade Grau I</td>
              </tr>
              <tr class="error">
                <td>35 a < 40</td><td>Obesidade Grau II (severa)</td>
              </tr>
              <tr class="error">
                <td>> 40</td><td>Obesidade Grau III (mórbida)</td>
              </tr>
            </tbody>
          </table>
      </div>
    </div>
  </div>
  <script>
    var last_update;
    var resultado = {valor: 0, mensagem: ''};

    $('.ui.dropdown').dropdown();
    $('#formulario').form({      
      fields: {
        sexo: {
          rules:[{
            type: 'empty',
            prompt: 'Sexo deve ser informado'
          }]          
        },
        idade: {
          rules:[{
            type: 'empty',
            prompt: 'Idade deve ser informado'
          }]          
        },
        peso: {
          rules:[{
            type: 'empty',
            prompt: 'Peso deve ser informado'
          }]          
        },
        altura: {
          rules:[{
            type: 'empty',
            prompt: 'Altura deve ser informado'
          }]          
        }
      },
      onFailure: function(){
        $('#mensagem_erro').modal('show');
        return false;
      }    
    });
  </script>
</body>
</html>
