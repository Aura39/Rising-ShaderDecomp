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
	r0.x = -fognearfar.x + fognearfar.y;
	r0.x = 1 / r0.x;
	r0.y = fognearfar.y + -texcoord.w;
	r0.x = r0.x * r0.y;
	r0.y = 1 / texcoord.w;
	r0.yz = r0.yy * texcoord.xy;
	r0.yz = r0.yz * 0.5 + 0.5;
	r1.xy = r0.yz * float2(2, -2) + float2(-1, 1);
	r0.yz = r0.yz + g_TargetUvParam.xy;
	r2 = tex2D(g_Sampler1, r0.yzzw);
	r0.y = r2.x * g_CameraParam.y + g_CameraParam.x;
	r0.zw = r0.yy * r1.xy;
	r1.z = -r0.y;
	r1.xy = r0.zw * g_CameraParam.zw;
	r1.w = 1;
	r2.x = dot(r1, transpose(g_ViewTexMtx)[0]);
	r2.y = dot(r1, transpose(g_ViewTexMtx)[1]);
	r0.yzw = r1.xyz + -g_ViewCenterPos.xyz;
	r0.y = dot(r0.yzw, g_Rate.xyz);
	r0.y = abs(r0.y) * g_Rate.w;
	r0.y = -r0.y + 1;
	r0.zw = r2.xy + 1;
	r1 = tex2D(g_Sampler0, r0.zwzw);
	r0.y = r0.y * r1.w;
	r2 = g_MatrialColor;
	r1.xyz = r1.xyz * r2.xyz + -fog.xyz;
	o.xyz = r0.xxx * r1.xyz + fog.xyz;
	r1 = r0.y * r2.w + -0.001;
	r0.x = r0.y * g_MatrialColor.w;
	o.w = r0.x;
	clip(r1);

	return o;
}
