{% macro conversion_when(vTimes) %}
  CASE 
        WHEN currency_iso_code = 'EUR' THEN EUR_rate * {{ vTimes }}
        WHEN currency_iso_code = 'USD' THEN USD_rate * {{ vTimes }}
        WHEN currency_iso_code = 'NOK' THEN NOK_rate * {{ vTimes }}
        WHEN currency_iso_code = 'DKK' THEN DKK_rate * {{ vTimes }}
        WHEN currency_iso_code = 'GBP' THEN GBP_rate * {{ vTimes }}
        WHEN currency_iso_code = 'JPY' THEN JPY_rate * {{ vTimes }}
        WHEN currency_iso_code = 'KRW' THEN KRW_rate * {{ vTimes }}
        WHEN currency_iso_code = 'AUD' THEN AUD_rate * {{ vTimes }}
        WHEN currency_iso_code = 'CHF' THEN CHF_rate * {{ vTimes }}
                ELSE {{ vTimes }}
    END 
{% endmacro %}