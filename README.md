# consultation_ad_powerShell

![image](https://github.com/anth039/consultation_ad_powerShell/assets/88208959/bdc84dae-c08e-4edb-80ac-321438a39551)



Application permettant d'afficher les informations des utilisateurs contenu dans un Active Directory (+Filtrage & +):
  - Nom
  - Prénom
  - ID
  - Email
  - Statut
  - Groupe
  - Site

Application composée de deux partie : 


  - RECUPERATION DES DONNEES

      Pré-requis :

    -  Service AD (Panneau de configuration => Programmes et fonctionnalités => Activer ou désactiver des fonctionnalités Windows)
    
    ![image](https://github.com/anth039/consultation_ad_powerShell/assets/88208959/b000e3fe-f3d0-4203-b8be-d18a6b9c90b9)

    - Les outils d'administration Windows : https://www.microsoft.com/fr-FR/download/details.aspx?id=45520 

    Il faut au préalable, remplir les données dans AD_code_get_user : 
    (Remplissage en fonction de votre domaine)
    
    (En début de code)
    
    
    ![image](https://github.com/anth039/consultation_ad_powerShell/assets/88208959/7794897c-a176-4f10-8de8-98effba8286b)
    
    
    (En fin de code)
    
    ![image](https://github.com/anth039/consultation_ad_powerShell/assets/88208959/802e17dc-7723-47a9-80a0-ab09b384539f)

    
    Après exécution de AD_code_get_user, cela génère un fichier Json contenant les informations de votre AD.


  - EXPLOITATION DES DONNEES

    Exécution de Consultation_AD (Dans le même répertoire ou se trouve le fichier de configuration)




