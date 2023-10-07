<?php

namespace App\Controller;

use App\Repository\ProductRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DownloadController extends AbstractController
{
    #[Route('/download/{id}', name: 'app_download')]
    public function index(ProductRepository $productRepository, int $id): Response
    {
        $product = $productRepository->find($id);


        if ($product->getFileName() !== null) {
            $filePath = '../ressources/products/' . $product->getFileName();

            if (file_exists($filePath)) {
                return $this->file($filePath);
            }
        }
        

        $this->addFlash(
            "warning",
            "Le fichié demandé n'existe plus ! Contactez le support."
        );
        return $this->redirectToRoute('user_products');
    }
}
