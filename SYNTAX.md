# Valid8 Template syntax

## Description

The syntax could be one of the following

### Syntax A

```yaml
---
default:
  ttl: 300
  value: {{ name }}.{{ zone }}
records:
  txt:
  cname:
    -
      name: "tm"
      value: "tm.contactlab.it"
    -
      name: "lm"
      value: "lm.contactlab.it"
  a:
  ns:
  mx:
```

### Syntax B

```yaml
---
default:
  ttl: 300
  value: {{ name }}.{{ zone }}
records:
  -
    name: "tm"
    value: "tm.contactlab.it"
    type: "cname"
  -
    name: "lm"
    value: "lm.contactlab.it"
    type: "cname"
```


## Things to check

- se "name" finisce con il . usarlo come fqdn, altrimenti relativo alla zona
- sintassi (a) o (b)
- sintassi a, tipo non duplicato

sintassi alternative
- record come quintetto (name, value, type, ttl) con opzionali tutti i record in default + opzionale MX
