include_directories(BEFORE SYSTEM ${Cufflinks_REQ_INCLUDES})

set(noinst_HEADERS
    update_check.h
    biascorrection.h
    codons.h
    clustering.h
    differential.h
    GArgs.h
    GBase.h
    gdna.h
    GFaSeqGet.h
    GFastaIndex.h
    gff.h
    GHash.hh
    GVec.hh
    GList.hh
    GStr.h
    assemble.h
    bundles.h
    filters.h
    hits.h
    tokenize.h
    scaffolds.h
    abundances.h
    genes.h
    transitive_closure.h
    transitive_reduction.h
    gff_utils.h
    gtf_tracking.h
    progressbar.h
    bundles.h
    scaffold_graph.h
    matching_merge.h
    graph_optimize.h
    jensen_shannon.h
    sampling.h
    lemon/maps.h
    lemon/bin_heap.h
    lemon/fib_heap.h
    lemon/bipartite_matching.h
    lemon/topology.h
    lemon/bucket_heap.h
    lemon/smart_graph.h
    lemon/list_graph.h
    lemon/error.h
    lemon/graph_utils.h
    lemon/bfs.h
    lemon/dfs.h
    lemon/math.h
    lemon/tolerance.h
    lemon/graph_adaptor.h
    lemon/concept_check.h
    lemon/bits/default_map.h
    lemon/bits/array_map.h
    lemon/bits/vector_map.h
    lemon/bits/debug_map.h
    lemon/bits/map_extender.h
    lemon/bits/base_extender.h
    lemon/bits/graph_adaptor_extender.h
    lemon/bits/graph_extender.h
    lemon/bits/invalid.h
    lemon/bits/path_dump.h
    lemon/bits/traits.h
    lemon/bits/utility.h
    lemon/bits/alteration_notifier.h
    lemon/bits/variant.h
    lemon/concepts/graph.h
    lemon/concepts/bpugraph.h
    lemon/concepts/graph_components.h
    lemon/concepts/ugraph.h
    lemon/concepts/heap.h
    lemon/concepts/maps.h
    lemon/concepts/path.h
    lemon/concepts/matrix_maps.h
    locfit/design.h
    locfit/lfcons.h
    locfit/lfstruc.h
    locfit/local.h
    locfit/imatlb.h
    locfit/lffuns.h
    locfit/lfwin.h
    locfit/mutil.h
    locfit/vari.hpp
    replicates.h
    multireads.h
    rounding.h
    negative_binomial_distribution.h
    tracking.h
    common.h)

set(libcufflinks_SOURCES
clustering.cpp 
differential.cpp 
common.cpp 
assemble.cpp 
tokenize.cpp 
abundances.cpp 
scaffolds.cpp 
hits.cpp 
genes.cpp 
bundles.cpp 
filters.cpp 
scaffold_graph.cpp 
matching_merge.cpp 
graph_optimize.cpp 
biascorrection.cpp 
sampling.cpp 
locfit/adap.c 
locfit/ar_funs.c 
locfit/arith.c 
locfit/band.c 
locfit/c_args.c 
locfit/c_plot.c 
locfit/cmd.c 
locfit/dens_haz.c 
locfit/dens_int.c 
locfit/dens_odi.c 
locfit/density.c 
locfit/dist.c 
locfit/ev_atree.c 
locfit/ev_interp.c 
locfit/ev_kdtre.c 
locfit/ev_main.c 
locfit/ev_trian.c 
locfit/family.c 
locfit/fitted.c 
locfit/frend.c 
locfit/help.c 
locfit/lf_dercor.c 
locfit/lf_fitfun.c 
locfit/lf_robust.c 
locfit/lf_vari.c 
locfit/lfd.c 
locfit/lfstr.c 
locfit/linalg.c 
locfit/locfit.c 
locfit/m_chol.c 
locfit/m_eigen.c 
locfit/m_jacob.c 
locfit/m_max.c 
locfit/makecmd.c 
locfit/math.c 
locfit/minmax.c 
locfit/nbhd.c 
locfit/pcomp.c 
locfit/pout.c 
locfit/preplot.c 
locfit/random.c 
locfit/readfile.c 
locfit/scb.c 
locfit/scb_cons.c 
locfit/simul.c 
locfit/solve.c 
locfit/startlf.c 
locfit/strings.c 
locfit/vari.cpp 
locfit/wdiag.c 
locfit/weight.c 
replicates.cpp 
multireads.cpp 
jensen_shannon.cpp 
tracking.cpp )

add_library(cufflinks_lib STATIC ${libcufflinks_SOURCES})
set_target_properties(cufflinks_lib PROPERTIES OUTPUT_NAME cufflinks.a)

set(libgc_SOURCES
codons.cpp 
GArgs.cpp 
GBase.cpp 
gdna.cpp 
GStr.cpp 
GFaSeqGet.cpp 
GFastaIndex.cpp 
gff.cpp 
gff_utils.cpp 
gtf_tracking.cpp)

add_library(gc STATIC ${libgc_SOURCES})

set(Cufflinks_REQ_LIBS ${Cufflinks_REQ_LIBS} gc)

#cuffcompare_SOURCES = cuffcompare.cpp
#cuffcompare_LDADD = libgc.a
add_executable(cuffcompare cuffcompare.cpp)
target_link_libraries(cuffcompare gc)

#gffread_SOURCES = gffread.cpp
#gffread_LDADD = libgc.a
add_executable(gffread gffread.cpp)
target_link_libraries(gffread gc)

set(Cufflinks_REQ_LIBS ${Cufflinks_REQ_LIBS} cufflinks_lib)

#cufflinks_SOURCES = cufflinks.cpp
#cufflinks_LDADD = libcufflinks.a libgc.a $(BOOST_THREAD_LIB) $(BOOST_SYSTEM_LIB)  $(BOOST_SERIALIZATION_LIB)  $(BAM_LIB)
#cufflinks_LDFLAGS =  $(LDFLAGS) $(BOOST_LDFLAGS) $(BAM_LDFLAGS) #$(ZLIB_LDFLAGS)
add_executable(cufflinks cufflinks.cpp)
target_link_libraries(cufflinks ${Cufflinks_REQ_LIBS})

#cuffdiff_SOURCES = cuffdiff.cpp
#cuffdiff_LDADD = libcufflinks.a libgc.a $(BOOST_THREAD_LIB) $(BOOST_SYSTEM_LIB) $(BOOST_SERIALIZATION_LIB) $(BAM_LIB)
#cuffdiff_LDFLAGS =  $(LDFLAGS) $(BOOST_LDFLAGS) $(BAM_LDFLAGS)
add_executable(cuffdiff cuffdiff.cpp)
target_link_libraries(cuffdiff ${Cufflinks_REQ_LIBS})

#gtf_to_sam_SOURCES = gtf_to_sam.cpp
#gtf_to_sam_LDADD = libcufflinks.a libgc.a $(BOOST_THREAD_LIB) $(BOOST_SYSTEM_LIB) $(BOOST_SERIALIZATION_LIB) $(BAM_LIB)
#gtf_to_sam_LDFLAGS =  $(LDFLAGS) $(BOOST_LDFLAGS) $(BAM_LDFLAGS)
add_executable(gtf_to_sam gtf_to_sam.cpp)
target_link_libraries(gtf_to_sam ${Cufflinks_REQ_LIBS})


#compress_gtf_SOURCES = compress_gtf.cpp
#compress_gtf_LDADD = libcufflinks.a libgc.a $(BOOST_THREAD_LIB) $(BOOST_SYSTEM_LIB) $(BOOST_SERIALIZATION_LIB) $(BAM_LIB)
#compress_gtf_LDFLAGS =  $(LDFLAGS) $(BOOST_LDFLAGS) $(BAM_LDFLAGS)
add_executable(compress_gtf compress_gtf.cpp)
target_link_libraries(compress_gtf ${Cufflinks_REQ_LIBS})


#cuffquant_SOURCES = cuffquant.cpp
#cuffquant_LDADD = libcufflinks.a libgc.a $(BOOST_THREAD_LIB) $(BOOST_SYSTEM_LIB) $(BOOST_SERIALIZATION_LIB) $(BAM_LIB)
#cuffquant_LDFLAGS =  $(LDFLAGS) $(BOOST_LDFLAGS) $(BAM_LDFLAGS)
add_executable(cuffquant cuffquant.cpp)
target_link_libraries(cuffquant ${Cufflinks_REQ_LIBS})


#cuffnorm_SOURCES = cuffnorm.cpp
#cuffnorm_LDADD = libcufflinks.a libgc.a $(BOOST_THREAD_LIB) $(BOOST_SYSTEM_LIB) $(BOOST_SERIALIZATION_LIB) $(BAM_LIB)
#cuffnorm_LDFLAGS =  $(LDFLAGS) $(BOOST_LDFLAGS) $(BAM_LDFLAGS)
add_executable(cuffnorm cuffnorm.cpp)
target_link_libraries(cuffnorm ${Cufflinks_REQ_LIBS})


##cuffcluster_SOURCES = cuffcluster.cpp
##cuffcluster_LDADD = libcufflinks.a libgc.a $(BOOST_THREAD_LIB) $(BOOST_SYSTEM_LIB) $(BOOST_SERIALIZATION_LIB) $(BAM_LIB)
##cuffcluster_LDFLAGS =  $(LDFLAGS) $(BOOST_LDFLAGS) $(BAM_LDFLAGS)
#add_executable(cuffcluster cuffcluster.cpp)
#target_link_libraries(cuffcluster ${Cufflinks_REQ_LIBS})


##gtf_reads_SOURCES = gtf_reads.cpp
##gtf_reads_LDADD = libcufflinks.a libgc.a $(BOOST_THREAD_LIB) $(BOOST_SYSTEM_LIB) $(BOOST_SERIALIZATION_LIB) $(BAM_LIB)
##gtf_reads_LDFLAGS =  $(LDFLAGS) $(BOOST_LDFLAGS) $(BAM_LDFLAGS) #$(ZLIB_LDFLAGS)
#add_executable(gtf_reads gtf_reads.cpp)
#target_link_libraries(gtf_reads ${Cufflinks_REQ_LIBS})


#TODO register this cuffmerge script to be installed
#-- scripts to be installed in $prefix/bin
#dist_bin_SCRIPTS = \
#cuffmerge
