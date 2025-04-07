#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <PulseSensorPlayground.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
#include <TimeLib.h>

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

WiFiUDP udp;
NTPClient timeClient(udp, "pool.ntp.org", 0, 60000);  // Ajuste o fuso horário conforme necessário

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

  // Iniciar o cliente NTP
  timeClient.begin();
  timeClient.setTimeOffset(-10800);  // Ajuste o fuso horário

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

      // Atualiza o tempo via NTP
      timeClient.update();

      // Obtém a hora atual
      int hours = timeClient.getHours();
      int minutes = timeClient.getMinutes();
      int seconds = timeClient.getSeconds();
      
      // Formata a hora no formato HH:MM:SS
      String horaStr = String(hours) + ":" + String(minutes) + ":" + String(seconds);

      // Define o tempo atual no formato TimeLib
      setTime(timeClient.getEpochTime());  // Define a hora atual usando o timestamp NTP

      // Obtém a data atual usando TimeLib
      int anoAtual = year();
      int mesAtual = month();
      int diaAtual = day();

      // Formata a data no formato MM/DD/AAAA
      String dataStr = (diaAtual < 10 ? "0" : "") + String(diaAtual) + "/" + (mesAtual < 10 ? "0" : "") + String(mesAtual) + "/" + String(anoAtual);

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
