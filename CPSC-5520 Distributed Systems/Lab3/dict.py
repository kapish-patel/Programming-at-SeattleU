dict = {}

dict['person1'] = {'kapish': (22, 32)}
dict['person2'] = {'krupal': (20, 22), 'het': (2782, 2002)}
dict['person3'] = {'ketul': (220, 232)}
dict['person4'] = {'raziq': (206, 224)}
dict['person5'] = {'nilay': (210, 228)}
if 'person2' in dict:
    if 'het' in dict['person2']:
        dic = dict['person2']
        dic['het'] = (2782, 2782)
        dict['person2'] = dic
        print(dict['person2'])
