float3 fog : register(c187);
float2 fognearfar : register(c188);
float4 g_CameraParam : register(c193);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
float4 g_TargetUvParam : register(c194);
float4 g_ViewCenterPos : register(c186);
float4x4 g_ViewTexMtx : register(c189);

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / texcoord.w;
	r0.xy = r0.xx * texcoord.xy;
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
	r1.w = r0.z * r1.w;
	r0 = r1.wxyz * g_MatrialColor.wxyz;
	r1.x = -fognearfar.x + fognearfar.y;
	r1.x = 1 / r1.x;
	r1.y = fognearfar.y + -texcoord.w;
	r1.x = r1.x * r1.y;
	r1.y = -r1.x + 1;
	r1.x = r1.x * r1.x;
	r0.yzw = fog.xyz * r1.yyy + r0.yzw;
	r0.x = r0.x;
	r1.y = r1.x * r0.x;
	r2 = r0.x * r1.x + -0.001;
	clip(r2);
	o.xyz = r0.yzw * r1.yyy;
	o.w = r1.y;

	return o;
}
