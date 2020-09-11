module ForecastIo
  module IrcHandlers
    #-# Handlers
    def handle_irc_forecast(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + forecast_text(forecast)
    end

    def handle_irc_ansirain(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ansi_rain_forecast(forecast)
    end

    def handle_irc_ascii_rain(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ascii_rain_forecast(forecast)
    end

    def handle_irc_all_the_things(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + forecast_text(forecast)
      response.reply location.location_name + ' ' + ansi_rain_forecast(forecast)
      response.reply location.location_name + ' ' + ansi_rain_intensity_forecast(forecast)
      response.reply location.location_name + ' ' + ansi_temp_forecast(forecast)
      response.reply location.location_name + ' ' + ansi_wind_direction_forecast(forecast)
      response.reply location.location_name + ' ' + do_the_sun_thing(forecast, ansi_chars)
      response.reply location.location_name + ' ' + do_the_cloud_thing(forecast, ansi_chars)
      response.reply location.location_name + ' ' + do_the_daily_rain_thing(forecast)
      response.reply location.location_name + ' ' + do_the_humidity_thing(forecast, ansi_chars, 'humidity')
    end

    def handle_irc_ansirain_intensity(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ansi_rain_intensity_forecast(forecast)
    end

    def handle_irc_ansitemp(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ansi_temp_forecast(forecast)
    end

    def handle_irc_ansitempapparent(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ansi_temp_forecast(forecast)
    end

    def handle_irc_ansiwindchill(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ansi_windchill_forecast(forecast)
    end

    def handle_irc_ieeetemp(response)
      @scale = 'k'
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ansi_temp_forecast(forecast)
    end

    def handle_irc_ascii_temp(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ascii_temp_forecast(forecast)
    end

    def handle_irc_daily_temp(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + ansi_temp_forecast(forecast, 48)
    end

    def handle_irc_conditions(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + conditions(forecast)
    end

    def handle_irc_ansiwind(response)
      response.reply "Sorry, darksky's api lies about wind now.  Try the main interface at https://darksky.net"
      # location = geo_lookup(response.user, response.match_data[1])
      # forecast = get_forecast_io_results(response.user, location)
      # response.reply location.location_name + ' ' + ansi_wind_direction_forecast(forecast)
    end

    def handle_irc_ascii_wind(response)
      response.reply "Sorry, darksky's api lies about wind now.  Try the main interface at https://darksky.net"
      # location = geo_lookup(response.user, response.match_data[1])
      # forecast = get_forecast_io_results(response.user, location)
      # response.reply location.location_name + ' ' + ascii_wind_direction_forecast(forecast)
    end

    def handle_irc_alerts(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      alerts = get_alerts(forecast)
      response.reply alerts
    end

    def handle_irc_ansisun(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_sun_thing(forecast, ansi_chars)
    end

    def handle_irc_dailysun(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_daily_sun_thing(forecast, ansi_chars)
    end

    def handle_irc_asciisun(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_sun_thing(forecast, ascii_chars)
    end

    def handle_irc_ansicloud(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_cloud_thing(forecast, ansi_chars)
    end

    def handle_irc_asciicloud(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_cloud_thing(forecast, ascii_chars)
    end

    def handle_irc_ansifog(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_fog_thing(forecast, ansi_chars)
    end

    def handle_irc_asciifog(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_fog_thing(forecast, ascii_chars)
    end

    def handle_irc_seven_day(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_seven_day_thing(forecast)
    end

    def handle_irc_daily_rain(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_daily_rain_thing(forecast)
    end

    def handle_irc_seven_day_rain(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_seven_day_rain_thing(forecast)
    end

    def handle_irc_daily_wind(response)
      response.reply "Sorry, darksky's api lies about wind now.  Try the main interface at https://darksky.net"
      # location = geo_lookup(response.user, response.match_data[1])
      # forecast = get_forecast_io_results(response.user, location)
      # response.reply location.location_name + ' ' + do_the_daily_wind_thing(forecast)
    end

    def handle_irc_daily_humidity(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_daily_humidity_thing(forecast)
    end

    def handle_irc_ansi_humidity(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' 48hr humidity ' + ansi_humidity_forecast(forecast)
    end

    def handle_irc_ansiozone(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_ozone_thing(forecast)
    end

    def handle_irc_ansi_pressure(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_pressure_thing(forecast)
    end

    def handle_irc_daily_pressure(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' ' + do_the_daily_pressure_thing(forecast)
    end

    def handle_irc_set_scale(response)
      key = response.user.name + '-scale'
      user_requested_scale = response.match_data[1].to_s.downcase
      reply = check_and_set_scale(key, user_requested_scale)
      response.reply reply
    end

    def handle_irc_sunrise(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' sunrise: ' + do_the_sunrise_thing(forecast)
    end

    def handle_irc_sunset(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      response.reply location.location_name + ' sunset: ' + do_the_sunset_thing(forecast)
    end

    def handle_irc_neareststorm(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      nearest_storm_distance, nearest_storm_bearing = do_the_nearest_storm_thing(forecast)

      if nearest_storm_distance == 0
        response.reply "You're in it!"
      else
        response.reply "The nearest storm is #{get_distance(nearest_storm_distance, get_scale(response.user))} to the #{get_cardinal_direction_from_bearing(nearest_storm_bearing)} of you."
      end

    end

    def handle_irc_tomorrow(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      tomorrow_will_be = do_the_tomorrow_thing(forecast)
      Lita.logger.info "Response: Tomorrow will be #{tomorrow_will_be} today."
      response.reply "Tomorrow will be #{tomorrow_will_be} today."
    end

    def handle_irc_today(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location, Date.today.to_s + 'T00:00:00-0700')
      yesterday_weather = get_forecast_io_results(response.user, location, Date.today.prev_day.to_s + 'T00:00:00-0700')
      today_will_be = do_the_today_thing(forecast, yesterday_weather)
      Lita.logger.info "Response: Today will be #{today_will_be} yesterday."
      response.reply "Today will be #{today_will_be} yesterday."
    end

    def handle_irc_windows(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      windows_time = do_the_windows_thing(forecast)
      response.reply "#{windows_time}"
    end

    def handle_http_windows(request, response)
      uri = config.api_uri + config.api_key + '/' + '45.535,-122.631'
      forecast = gimme_some_weather uri
      windows_data = do_the_windows_data_thing(forecast)
      response.write windows_data.to_json
    end

    def handle_irc_uvindex(response)
      location = geo_lookup(response.user, response.match_data[1])
      forecast = get_forecast_io_results(response.user, location)
      str = do_the_uvindex_thing(forecast)
      response.reply "UV Index for #{location.location_name} #{str} [48h forecast]"
    end

    def handle_http_cat(response)
      codes = {'100': 'Continue',
      '101': 'Switching Protocols',
      '102': 'Processing (WebDAV)',
      '200': 'OK',
      '201': 'Created',
      '202': 'Accepted',
      '203': 'Non-Authoritative Information',
      '204': 'No Content',
      '205': 'Reset Content',
      '206': 'Partial Content',
      '207': 'Multi-Status (WebDAV)',
      '208': 'Already Reported (WebDAV)',
      '226': 'IM Used',
      '300': 'Multiple Choices',
      '301': 'Moved Permanently',
      '302': 'Found',
      '303': 'See Other',
      '304': 'Not Modified',
      '305': 'Use Proxy',
      '306': '(Unused)',
      '307': 'Temporary Redirect',
      '308': 'Permanent Redirect (experimental)',
      '400': 'Bad Request',
      '401': 'Unauthorized',
      '402': 'Payment Required',
      '403': 'Forbidden',
      '404': 'Not Found',
      '405': 'Method Not Allowed',
      '406': 'Not Acceptable',
      '407': 'Proxy Authentication Required',
      '408': 'Request Timeout',
      '409': 'Conflict',
      '410': 'Gone',
      '411': 'Length Required',
      '412': 'Precondition Failed',
      '413': 'Request Entity Too Large',
      '414': 'Request-URI Too Long',
      '415': 'Unsupported Media Type',
      '416': 'Requested Range Not Satisfiable',
      '417': 'Expectation Failed',
      '418': 'I\'m a teapot (RFC 2324)',
      '420': 'Enhance Your Calm (Twitter)',
      '422': 'Unprocessable Entity (WebDAV)',
      '423': 'Locked (WebDAV)',
      '424': 'Failed Dependency (WebDAV)',
      '425': 'Reserved for WebDAV',
      '426': 'Upgrade Required',
      '428': 'Precondition Required',
      '429': 'Too Many Requests',
      '431': 'Request Header Fields Too Large',
      '444': 'No Response (Nginx)',
      '449': 'Retry With (Microsoft)',
      '450': 'Blocked by Windows Parental Controls (Microsoft)',
      '451': 'Unavailable For Legal Reasons',
      '499': 'Client Closed Request (Nginx)',
      '500': 'Internal Server Error',
      '501': 'Not Implemented',
      '502': 'Bad Gateway',
      '503': 'Service Unavailable',
      '504': 'Gateway Timeout',
      '505': 'HTTP Version Not Supported',
      '506': 'Variant Also Negotiates (Experimental)',
      '507': 'Insufficient Storage (WebDAV)',
      '508': 'Loop Detected (WebDAV)',
      '509': 'Bandwidth Limit Exceeded (Apache)',
      '510': 'Not Extended',
      '511': 'Network Authentication Required',
      '598': 'Network read timeout error',
      '599': 'Network connect timeout error'}

      code = response.match_data[1]

      # if statement brought to you by the efforts of master hacker aaronpk
      response.reply "https://http.cat/#{code}.jpg #{codes[code.to_sym]}"  if codes[code.to_sym]
    end

    def handle_sandytraffic(response)
      response.reply("!sandytraffic #{response.matches[0][0]}")
    end

    def handle_ansi_aqi(response)
      if response.matches[0][0].length > 1
        Lita.logger.debug response.matches[0][0]
        Lita.logger.debug "Performing sensor sweep"
        show = response.matches[0][0]
      else
        Lita.logger.debug response.user.name
        if response.user.name == 'lampd1'
          show = '38447'
        elsif response.user.name == 'aaronpk' or response.user.name == 'zenlinux'
          show = '43023'
        elsif response.user.name == 'djwong'
          show = '61137'
        elsif response.user.name == 'philtor'
          show = '35221'
        else
          Lita.logger.debug "Defaulting to pdx"
          show = "9814"
        end
      end
      resp = RestClient.get "https://www.purpleair.com/json?show=#{show}"
      aqi = JSON.parse resp
      label = aqi['results'][0]['Label']
      stats = JSON.parse aqi['results'][0]['Stats']
      Lita.logger.debug stats
      aqis = [stats['v5'],
              stats['v4'],
              stats['v3'],
              stats['v2'],
              stats['v1'],
              stats['v']]

      reply = do_the_aqi_thing(aqis)
      response.reply "AQI report for #{label}: PM2.5 #{reply} \x03#{colors[:grey]}(7 day average to 10 min average)\x03"
      # response.reply "\x03#{colors[color]}█\x03"

    end
  end
end
