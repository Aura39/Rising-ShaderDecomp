float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
float4 g_TargetUvParam;
float4 g_ViewCenterPos;
float4x4 g_ViewTexMtx;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

struct PS_OUT
{
	float4 color : COLOR;
	float4 color2 : COLOR2;
	float4 color1 : COLOR1;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / i.texcoord.w;
	r0.xy = r0.xx * i.texcoord.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.zw = r0.xy * float2(2, -2) + float2(2, -2);
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r1 = tex2D(g_Sampler1, r0);
	r0.x = r1.x * g_CameraParam.y + g_CameraParam.x;
	r0.yz = r0.xx * r0.zw;
	r1.z = -r0.x;
	r1.xy = r0.yz * g_CameraParam.zw;
	r1.w = 1;
	r0.x = dot(r1, transpose(g_ViewTexMtx)[0]);
	r0.y = dot(r1, transpose(g_ViewTexMtx)[1]);
	r1.xyz = r1.xyz + -g_ViewCenterPos.xyz;
	r0.z = dot(r1.xyz, g_Rate.xyz);
	r0.z = abs(r0.z) * g_Rate.w;
	r0.z = -r0.z + 1;
	r0.xy = r0.xy + 1;
	r1 = tex2D(g_Sampler0, r0);
	r2 = r1.w * r0.z + -0.01;
	r1.w = r0.z * r1.w;
	r0 = r1 * g_MatrialColor;
	clip(r2);
	o.color = r0;
	o.color2 = r0;
	o.color1 = i.texcoord1.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);

	return o;
}
