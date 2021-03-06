
# parsetab.py
# This file is automatically generated. Do not edit.
_tabversion = '3.2'

_lr_method = 'LALR'

_lr_signature = b'y\x0b\x03\x98\x19\xe3\xae\x04\x85s)\xfe\xd3*\x07:'
    
_lr_action_items = {'WORD':([1,2,4,5,7,8,9,10,11,12,13,14,15,],[5,-3,6,9,-2,-9,-7,-8,-10,-6,9,-4,-5,]),'STR_LIT':([5,8,9,10,11,12,13,15,],[8,-9,-7,-8,-10,-6,8,-5,]),'INT_LIT':([5,8,9,10,11,12,13,15,],[10,-9,-7,-8,-10,-6,10,-5,]),'BFC_LIT':([5,8,9,10,11,12,13,15,],[11,-9,-7,-8,-10,-6,11,-5,]),':':([0,2,4,7,14,],[1,-3,1,-2,-4,]),';':([8,9,10,11,12,13,15,],[-9,-7,-8,-10,-6,14,-5,]),'$end':([3,6,],[0,-1,]),}

_lr_action = { }
for _k, _v in _lr_action_items.items():
   for _x,_y in zip(_v[0],_v[1]):
      if not _x in _lr_action:  _lr_action[_x] = { }
      _lr_action[_x][_k] = _y
del _lr_action_items

_lr_goto_items = {'definition':([0,4,],[2,7,]),'element':([5,13,],[12,15,]),'program':([0,],[3,]),'statement':([5,],[13,]),'definitions':([0,],[4,]),}

_lr_goto = { }
for _k, _v in _lr_goto_items.items():
   for _x,_y in zip(_v[0],_v[1]):
       if not _x in _lr_goto: _lr_goto[_x] = { }
       _lr_goto[_x][_k] = _y
del _lr_goto_items
_lr_productions = [
  ("S' -> program","S'",1,None,None,None),
  ('program -> definitions WORD','program',2,'p_program','forth2bf.py',58),
  ('definitions -> definitions definition','definitions',2,'p_definitions','forth2bf.py',62),
  ('definitions -> definition','definitions',1,'p_definitions_definition','forth2bf.py',66),
  ('definition -> : WORD statement ;','definition',4,'p_definition','forth2bf.py',70),
  ('statement -> statement element','statement',2,'p_statement','forth2bf.py',74),
  ('statement -> element','statement',1,'p_statement_word','forth2bf.py',78),
  ('element -> WORD','element',1,'p_element_word','forth2bf.py',82),
  ('element -> INT_LIT','element',1,'p_element_int','forth2bf.py',86),
  ('element -> STR_LIT','element',1,'p_element_str','forth2bf.py',90),
  ('element -> BFC_LIT','element',1,'p_element_bfc','forth2bf.py',98),
]
