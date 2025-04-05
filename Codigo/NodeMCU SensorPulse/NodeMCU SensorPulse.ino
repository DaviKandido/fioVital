#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <PulseSensorPlayground.h> // Inclui a biblioteca PulseSensorPlayground

// Configurações de Wi-Fi
const char *WIFI_SSID = "HackaTruckIoT";
const char *WIFI_PASSWORD = "iothacka";
const char *URL = "http://192.168.128.100:1880/postDezim"; // Endereço do servidor

// Sensor de pulso
const int PulseWire = 0;       // PulseSensor conectado ao pino analógico 0
const int LED = LED_BUILTIN;    // LED integrado
int Threshold = 550;           // Limite para detectar batimento

WiFiClient client;
HTTPClient httpClient;

PulseSensorPlayground pulseSensor;  // Cria o objeto pulseSensor

unsigned long lastTime = 0;
unsigned long delayTime = 1000;  // Delay de 1 segundo entre leituras

void setup() {
  Serial.begin(115200);  // Para monitor serial
  // Conectar-se ao Wi-Fi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Conectado à rede Wi-Fi!");

  // Configurar o PulseSensor
  pulseSensor.analogInput(PulseWire);  
  pulseSensor.blinkOnPulse(LED);        // Piscar o LED integrado com o batimento
  pulseSensor.setThreshold(Threshold);

  if (pulseSensor.begin()) {
    Serial.println("PulseSensor iniciado!");
  } else {
    Serial.println("Erro ao iniciar o PulseSensor.");
  }
}

void loop() {
  // Verifica se já passou o tempo de delay
  if (millis() - lastTime > delayTime) {
    lastTime = millis();  // Atualiza o tempo

    // Verifica se há um batimento
    if (pulseSensor.sawStartOfBeat()) {
      int myBPM = pulseSensor.getBeatsPerMinute();
      Serial.println("♥  A HeartBeat Happened !");
      Serial.print("BPM: ");
      Serial.println(myBPM);

      // Obter data e hora
      unsigned long currentMillis = millis();  // Pega o tempo em milissegundos desde o boot
      int seconds = (currentMillis / 1000) % 60;
      int minutes = (currentMillis / 60000) % 60;
      int hours = (currentMillis / 3600000) % 24;

      String rawDate = String(__DATE__);  // Ex: "Apr  4 2025"
      String monthStr = rawDate.substring(0, 3);  // "Apr"
      String day = rawDate.substring(4, 6);       // " 4" ou "14"
      String year = rawDate.substring(7);         // "2025"

      // Remove espaço do dia (caso seja " 4") e converte pra int
      int dayInt = day.toInt();
      String dayFormatted = (dayInt < 10) ? "0" + String(dayInt) : String(dayInt);

      // Converte o mês de nome para número com zero à esquerda
      String monthNum;
      if (monthStr == "Jan") monthNum = "01";
      else if (monthStr == "Feb") monthNum = "02";
      else if (monthStr == "Mar") monthNum = "03";
      else if (monthStr == "Apr") monthNum = "04";
      else if (monthStr == "May") monthNum = "05";
      else if (monthStr == "Jun") monthNum = "06";
      else if (monthStr == "Jul") monthNum = "07";
      else if (monthStr == "Aug") monthNum = "08";
      else if (monthStr == "Sep") monthNum = "09";
      else if (monthStr == "Oct") monthNum = "10";
      else if (monthStr == "Nov") monthNum = "11";
      else if (monthStr == "Dec") monthNum = "12";

      // Monta data final no formato MM/DD/AAAA
      String dataStr = monthNum + "/" + dayFormatted + "/" + year;


      String horaStr = String(__TIME__);  // "20:28:47"

      // Monta o JSON
      String json = "{\"id\": \"607\", \"bpm\": \"" + String(myBPM) + "\", \"data\": \"" + dataStr + "\", \"hora\": \"" + horaStr + "\"}";

      // Envia os dados para o servidor via HTTP POST
      httpClient.begin(client, URL);
      httpClient.addHeader("Content-Type", "application/json");

      // Definir um timeout para a requisição HTTP
      httpClient.setTimeout(5000);  // Tempo de espera de 5 segundos para a resposta

      int httpResponseCode = httpClient.POST(json);

      if (httpResponseCode > 0) {
        String content = httpClient.getString();
        Serial.println("Resposta do servidor: ");
        Serial.println(content);
      } else {
        Serial.print("Erro ao enviar dados. Código de resposta HTTP: ");
        Serial.println(httpResponseCode);
      }

      // Finaliza a requisição HTTP
      httpClient.end();
    }
  }
}
