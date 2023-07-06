float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
float4 g_TargetUvParam;
float4 g_UvParam;
float4 g_ViewCenterPos;
float4x4 g_ViewTexMtx;

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.x = 1 / texcoord.w;
	r0.xy = r0.xx * texcoord.xy;
	r1.xy = float2(0.5, -0.5);
	r0.zw = r0.xy * r1.xy + g_TargetUvParam.xy;
	r0.zw = r0.zw + 0.5;
	r1 = tex2D(g_Sampler1, r0.zwzw);
	r0.z = r1.x * g_CameraParam.y + g_CameraParam.x;
	r0.xy = r0.zz * r0.xy;
	r1.z = -r0.z;
	r1.xy = r0.xy * g_CameraParam.zw;
	r1.w = 1;
	r0.x = dot(r1, transpose(g_ViewTexMtx)[0]);
	r0.y = dot(r1, transpose(g_ViewTexMtx)[1]);
	r1.xyz = r1.xyz + -g_ViewCenterPos.xyz;
	r0.z = dot(r1.xyz, g_Rate.xyz);
	r0.z = abs(r0.z) * g_Rate.w;
	r0.z = -r0.z + 1;
	r1.xy = r0.xy + 1;
	r2 = (r0.x >= 0) ? -1 : -0;
	clip(r2);
	r2 = (r0.y >= 0) ? -1 : -0;
	clip(r2);
	r0.xy = (-r1.xy >= 0) ? -1 : -0;
	r1.xy = r1.xy * g_UvParam.xy + g_UvParam.zw;
	r1 = tex2D(g_Sampler0, r1);
	r2 = r0.x;
	r3 = r0.y;
	clip(r3);
	clip(r2);
	r2 = r1.w * r0.z + -0.001;
	r1.w = r0.z * r1.w;
	o = r1 * g_MatrialColor;
	clip(r2);

	return o;
}
