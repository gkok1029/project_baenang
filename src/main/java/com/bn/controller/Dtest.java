package com.bn.controller;

import java.util.ArrayList;
import java.util.List;

public class Dtest {

    public static void main(String[] args) {
        String[] destinations = {"mapx=126.4946032358, mapy=33.2620894948", "mapx=126.7640945189, mapy=33.4734065616", "mapx=126.5238756154, mapy=33.5118484611",
                "mapx=126.5867476162, mapy=33.5255451704", "mapx=126.3809026350, mapy=33.4810246035"};
        List<List<String>> permutations = generateAllPermutations(destinations);

        for (List<String> permutation : permutations) {
            // 각 순열에서 mapx와 mapy 값을 분리하여 출력
            for (String destination : permutation) {
                String[] parts = destination.split(", ");
               api(parts[0],parts[1],parts[2],parts[3]);
               api(parts[2],parts[3],parts[4],parts[5]);
               api(parts[6],parts[7],parts[8],parts[9]);
               api(parts[10],parts[11],parts[12],parts[13]);
               
            }
            System.out.println();
        }
    }

    public static List<List<String>> generateAllPermutations(String[] destinations) {
        List<List<String>> result = new ArrayList<>();
        generatePermutations(destinations, 0, result);
        return result;
    }

    private static void generatePermutations(String[] destinations, int currentIndex, List<List<String>> result) {
        if (currentIndex == destinations.length - 1) {
            // 배열의 끝에 도달하면 현재 상태를 결과에 추가
            List<String> permutation = new ArrayList<>();
            for (String destination : destinations) {
                permutation.add(destination);
            }
            result.add(permutation);
            return;
        }

        for (int i = currentIndex; i < destinations.length; i++) {
            // 배열의 각 요소와 현재 위치의 요소를 교환하지 않고 그대로 사용
            // 재귀적으로 다음 위치의 순열을 생성
            generatePermutations(destinations, currentIndex + 1, result);
        }
    }
}
