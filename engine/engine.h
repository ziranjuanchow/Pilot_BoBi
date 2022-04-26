//
// Created by Maxwell on 2022/4/27.
//

#pragma once

#include <atomic>

namespace PilotBobi
{
    class PilotBobiRenderer;
    class FrameBuffer;
    class SurfaceIO;

    extern bool g_is_editor_mode;

    struct EngineInitParams
    {
        std::filesystem::path m_root_folder;
        std::filesystem::path m_config_file_path;
    };

    class ThreeFrameBuffers
    {
        union TriBuffer
        {
            struct _Struct
            {
                FrameBuffer* _A;
                FrameBuffer* _B;
                FrameBuffer* _C;
            }_struct;
            FrameBuffer*(_array)[3];

        }three_buffers;

        std::atomic<size_t> m_logical_frame_index {0};
        size_t              m_last_producing_index {0};
        size_t              m_producing_index {0};
        size_t              m_consuming_index {0};

    public:
        void                initialize();
        void                clear();

    };


}
