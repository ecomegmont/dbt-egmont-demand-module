{% macro conversion_when(vTimes) %}
  CASE 
        WHEN currency_iso_code = 'EUR' THEN EUR_rate * {{ column_name }}
        WHEN currency_iso_code = 'USD' THEN USD_rate * {{ column_name }}
        WHEN currency_iso_code = 'NOK' THEN NOK_rate * {{ column_name }}
        WHEN currency_iso_code = 'DKK' THEN DKK_rate * {{ column_name }}
        WHEN currency_iso_code = 'GBP' THEN GBP_rate * {{ column_name }}
        WHEN currency_iso_code = 'JPY' THEN JPY_rate * {{ column_name }}
        WHEN currency_iso_code = 'KRW' THEN KRW_rate * {{ column_name }}
        WHEN currency_iso_code = 'AUD' THEN AUD_rate * {{ column_name }}
        WHEN currency_iso_code = 'CHF' THEN CHF_rate * {{ column_name }}
                ELSE {{ column_name }}
    END 
{% endmacro %}