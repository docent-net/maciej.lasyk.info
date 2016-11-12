Title: Way to go RedHat! RHEL 6.5 released
Date: 2013-12-05 18:46
Author: docent
Category: tech
Tags: centos, release, rhel
Slug: way-to-go-redhat-rhel-6-5-released
Status: published

<!--:en-->

[![RedHat](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/redhat.png){.aligncenter
.wp-image-435 width="173"
height="173"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/redhat.png)

So it finally happened - we've got 6.5 in stock :) Also DistroWatch
alerted about Centos 6.5 release: <http://distrowatch.com/?newsid=08190>

What's interesting here? (Listing only those ones that I think are
really worth of mentioning - for full list see references in the bottom
of this post):

-   <span style="line-height: 13px;"><span
    style="line-height: 13px;">Kernel / </span></span><span
    style="line-height: 22px;">New Supported Compression Formats for
    makedumpfile:</span>In Red Hat Enterprise Linux 6.5, the
    makedumpfile utility supports the LZO and snappy
    compression formats. Using these compression formats instead of the
    zlib format is quicker, in particular when compressing data with
    randomized content.
-   Networking:
    -   Precision Time Protocol - An implementation of the Precision
        Time Protocol (PTP) according to IEEE standard 1588-2008 for
        Linux was introduced as a Technology Preview in Red Hat
        Enterprise Linux 6.4. The PTP infrastructure, both kernel and
        user space, is now fully supported in Red Hat Enterprise
        Linux 6.5. Network driver time stamping support now also
        includes the following drivers: bnx2x, tg3, e1000e, igb, ixgbe,
        and sfc.
    -   Analyzing the Non-Configuration IP Multicast IGMP Snooping Data
        - Previously, the bridge module sysfs virtual file system did
        not provide the ability to inspect the non-configuration IP
        multicast Internet Group Management Protocol (IGMP)
        snooping data. Without this functionality, users could not fully
        analyze their multicast traffic. In Red Hat Enterprise Linux
        6.5, users are able to list detected multicast router ports,
        groups with active subscribers and the associated interfaces.
    -   Network Namespace Support for OpenStack - Network
        namespaces (netns) is a lightweight container-based
        virtualization technology. A virtual network stack can be
        associated with a process group. Each namespace has its own
        loopback device and process space. Virtual or real devices can
        be added to each network namespace, and the user can assign IP
        addresses to these devices and use them as a network node.
-   Virtualization / KVM:
    -   Native Support for GlusterFS in QEMU - Native Support for
        GlusterFS in QEMU allows native access to GlusterFS volumes
        using the libgfapi library instead of through a locally mounted
        FUSE file system. This native approach offers considerable
        performance improvements.
    -   Support for Dumping Metadata of Virtual Disks - This low-level
        feature uses the newly introduced command option qemu-img map to
        create an index that allows a qcow2 image to be mapped to a
        block device via LVM. As a result, virtual machine images (with
        the virtual machine shutdown) can be accessed as block devices.
        This is useful for backup applications that are now able to read
        guest image contents without knowing the details of the qcow2
        image format.
    -   CPU Hot Plugging for Linux Guests - CPU hot plugging and hot
        unplugging are supported with the help of the QEMU guest agent
        on Linux guests; CPUs can be enabled or disabled while the guest
        is running, thus mimicking the hot plug or hot unplug feature.
    -   Application-Aware freeze and thaw on Linux Using qemu-ga Hooks
        - Similar to the Windows VSS version, application-consistent
        snapshots can be created with the use of scripts that attach to
        the QEMU guest agent running on the guest. These scripts can
        notify applications which would flush their data to the disk
        during a freeze or thaw operation, thus allowing consistent
        snapshots to be taken.
    -   Host and Guest Panic Notification in KVM - A new pvpanic virtual
        device can be wired into the virtualization stack such that a
        guest panic can cause libvirt to send a notification event to
        management applications. This feature is introduced in Red Hat
        Enterprise Linux 6.5 as a Technology Preview. Note that enabling
        the use of this device requires the use of additional qemu
        command line options; this release does not include any
        supported way for libvirt to set those options.
-   Storage:
    -   Full Support of fsfreeze - The fsfreeze tool is fully supported
        in Red Hat Enterprise Linux 6.5. The fsfreeze command halts
        access to a file system on a disk. fsfreeze is designed to be
        used with hardware RAID devices, assisting in the creation of
        volume snapshots. For more details on the fsfreeze utility,
        refer to the fsfreeze(8) man page.
    -   pNFS File Layout Hardening - pNFS allows traditional NFS systems
        to scale out in traditional NAS environments, by allowing the
        compute clients to read and write data directly and in parallel,
        to and from the physical storage devices. The NFS server is used
        only to control meta-data and coordinate access, allowing
        predictably scalable access to very large sets from
        many clients. Bug fixes to pNFS are being delivered in
        this release.
    -   Support of Red Hat Storage in FUSE - FUSE (Filesystem in
        User Space) is a framework that enables development of file
        systems purely in the user space without requiring modifications
        to the kernel. Red Hat Enterprise Linux 6.5 delivers performance
        enhancements for user space file systems that use FUSE, for
        example, GlusterFS (Red Hat Storage).
    -   TRIM Support in mdadm - The mdadm tool now supports the TRIM
        commands for RAID0, RAID1, RAID10 and RAID5.
-   Clustering - <span style="line-height: 22px;">pacemaker Fully
    Supported</span>Pacemaker, a scalable high-availability cluster
    resource manager, which was previously included as a Technology
    Preview, is now fully supported in combination with Red Hat
    OpenStack deployments.

So now let's yum update ;)

References:

-   <span
    style="line-height: 13px;"><https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/6.5_Release_Notes/></span>
-   <http://wiki.centos.org/Manuals/ReleaseNotes/CentOS6.5>

<!--:--><!--:pl-->

-   [![RedHat](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/redhat.png){width="173"
    height="173"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/redhat.png)

     

    So it finally happened - we've got 6.5 in stock :) Also DistroWatch
    alerted about Centos 6.5
    release: <http://distrowatch.com/?newsid=08190>

    What's interesting here? (Listing only those ones that I think are
    really worth of mentioning - for full list see references in the
    bottom of this post):

    -   Kernel / New Supported Compression Formats for makedumpfile:In
        Red Hat Enterprise Linux 6.5, the makedumpfile utility supports
        the LZO and snappy compression formats. Using these compression
        formats instead of the zlib format is quicker, in particular
        when compressing data with randomized content.
    -   Networking:
        -   Precision Time Protocol - An implementation of the Precision
            Time Protocol (PTP) according to IEEE standard 1588-2008 for
            Linux was introduced as a Technology Preview in Red Hat
            Enterprise Linux 6.4. The PTP infrastructure, both kernel
            and user space, is now fully supported in Red Hat Enterprise
            Linux 6.5. Network driver time stamping support now also
            includes the following drivers: bnx2x, tg3, e1000e, igb,
            ixgbe, and sfc.
        -   Analyzing the Non-Configuration IP Multicast IGMP Snooping
            Data - Previously, the bridge module sysfs virtual file
            system did not provide the ability to inspect the
            non-configuration IP multicast Internet Group Management
            Protocol (IGMP) snooping data. Without this functionality,
            users could not fully analyze their multicast traffic. In
            Red Hat Enterprise Linux 6.5, users are able to list
            detected multicast router ports, groups with active
            subscribers and the associated interfaces.
        -   Network Namespace Support for OpenStack - Network
            namespaces (netns) is a lightweight container-based
            virtualization technology. A virtual network stack can be
            associated with a process group. Each namespace has its own
            loopback device and process space. Virtual or real devices
            can be added to each network namespace, and the user can
            assign IP addresses to these devices and use them as a
            network node.
    -   Virtualization / KVM:
        -   Native Support for GlusterFS in QEMU - Native Support for
            GlusterFS in QEMU allows native access to GlusterFS volumes
            using the libgfapi library instead of through a locally
            mounted FUSE file system. This native approach offers
            considerable performance improvements.
        -   Support for Dumping Metadata of Virtual Disks - This
            low-level feature uses the newly introduced command option
            qemu-img map to create an index that allows a qcow2 image to
            be mapped to a block device via LVM. As a result, virtual
            machine images (with the virtual machine shutdown) can be
            accessed as block devices. This is useful for backup
            applications that are now able to read guest image contents
            without knowing the details of the qcow2 image format.
        -   CPU Hot Plugging for Linux Guests - CPU hot plugging and hot
            unplugging are supported with the help of the QEMU guest
            agent on Linux guests; CPUs can be enabled or disabled while
            the guest is running, thus mimicking the hot plug or hot
            unplug feature.
        -   Application-Aware freeze and thaw on Linux Using qemu-ga
            Hooks - Similar to the Windows VSS version,
            application-consistent snapshots can be created with the use
            of scripts that attach to the QEMU guest agent running on
            the guest. These scripts can notify applications which would
            flush their data to the disk during a freeze or thaw
            operation, thus allowing consistent snapshots to be taken.
        -   Host and Guest Panic Notification in KVM - A new pvpanic
            virtual device can be wired into the virtualization stack
            such that a guest panic can cause libvirt to send a
            notification event to management applications. This feature
            is introduced in Red Hat Enterprise Linux 6.5 as a
            Technology Preview. Note that enabling the use of this
            device requires the use of additional qemu command line
            options; this release does not include any supported way for
            libvirt to set those options.
    -   Storage:
        -   Full Support of fsfreeze - The fsfreeze tool is fully
            supported in Red Hat Enterprise Linux 6.5. The fsfreeze
            command halts access to a file system on a disk. fsfreeze is
            designed to be used with hardware RAID devices, assisting in
            the creation of volume snapshots. For more details on the
            fsfreeze utility, refer to the fsfreeze(8) man page.
        -   pNFS File Layout Hardening - pNFS allows traditional NFS
            systems to scale out in traditional NAS environments, by
            allowing the compute clients to read and write data directly
            and in parallel, to and from the physical storage devices.
            The NFS server is used only to control meta-data and
            coordinate access, allowing predictably scalable access to
            very large sets from many clients. Bug fixes to pNFS are
            being delivered in this release.
        -   Support of Red Hat Storage in FUSE - FUSE (Filesystem in
            User Space) is a framework that enables development of file
            systems purely in the user space without requiring
            modifications to the kernel. Red Hat Enterprise Linux 6.5
            delivers performance enhancements for user space file
            systems that use FUSE, for example, GlusterFS (Red
            Hat Storage).
        -   TRIM Support in mdadm - The mdadm tool now supports the TRIM
            commands for RAID0, RAID1, RAID10 and RAID5.
    -   Clustering - pacemaker Fully SupportedPacemaker, a scalable
        high-availability cluster resource manager, which was previously
        included as a Technology Preview, is now fully supported in
        combination with Red Hat OpenStack deployments.

    So now let's yum update ;)

    References:

    -   <https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/6.5_Release_Notes/>
    -   <http://wiki.centos.org/Manuals/ReleaseNotes/CentOS6.5>

<!--:-->
