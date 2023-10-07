<?php

namespace App\DataFixtures;

use Faker\Factory;
use App\Entity\User;
use Faker\Generator;
use App\Entity\Product;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;

class AppFixtures extends Fixture
{
    private Generator $faker;

    public function __construct()
    {
        $this->faker = Factory::create('fr_FR');
    }

    public function load(ObjectManager $manager): void
    {

        // Users
        $users = [];
        for ($i = 0; $i < 10; $i++) {
            $user = new User();
            $user->setFirstName($this->faker->name())
                ->setLastName($this->faker->name())
                ->setEmail($this->faker->email())
                ->setRoles(['ROLE_USER'])
                ->setPlainPassword('password');

            $users[] = $user;
            $manager->persist($user);
        }

        $products = [];
        for ($i = 0; $i < 50; $i++) {
            $product = new Product();
            $product->setTitle($this->faker->word())
                ->setSummary($this->faker->text())
                ->setDescription($this->faker->text())
                ->setPublisher($this->faker->name())
                ->setPrice(mt_rand(1, 999))
                ->setType(mt_rand(0, 1) == 1 ? 'sample' : 'plugin')
                ->setCategory(mt_rand(0, 1) == 1 ? 'effet' : 'traitement')
                ->setGenre(mt_rand(0, 1) == 1 ? 'hip-hop' : 'electro')
                ->setImage("https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg");

            $products[] = $product;
            $manager->persist($product);
        }


        $manager->flush();
    }
}
