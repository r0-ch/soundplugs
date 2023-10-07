<?php

namespace App\Form;

use App\Entity\Product;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ProductDisplayType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('sort', ChoiceType::class, [
                'attr' => [
                    'class' => 'form-select mb-2'
                ],
                'label' => 'Trier',
                'label_attr' => [
                    'class' => 'form-label '
                ],
                'mapped' => false,
                'choices'  => [
                    'trier' => null,
                    'prix croissant' => 'price_ASC',
                    'prix décroissant' => 'price_DESC',
                    'nouveautés' => 'date_DESC'
                ],
            ])
            ->add('category', ChoiceType::class, [
                'multiple' => true,
                'expanded' => true,
                'attr' => [
                    'class' => 'form-check-input mb-2'
                ],
                'label' => 'Catégorie',
                'label_attr' => [
                    'class' => 'form-check-label '
                ],
                'choices'  => [
                    'effet' => 'effet',
                    'traitement' => 'traitement',
                ],
            ])
            ->add('genre', ChoiceType::class, [
                'multiple' => true,
                'expanded' => true,
                'attr' => [
                    'class' => 'form-check-input mb-2'
                ],
                'label' => 'Genre',
                'label_attr' => [
                    'class' => 'form-check-label '
                ],
                'choices'  => [
                    'hip-hop' => 'hip-hop',
                    'electro' => 'electro',
                ],
            ])
            ->add('submit', SubmitType::class, [
                'attr' => [
                    'class' => 'btn btn-primary'
                ]
            ]);
    }

    // public function configureOptions(OptionsResolver $resolver): void
    // {
    //     $resolver->setDefaults([
    //         'data_class' => Product::class,
    //     ]);
    // }
}
