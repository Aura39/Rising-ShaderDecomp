sampler Shadow_Tex_sampler : register(s11);
float4 g_CameraParam : register(c193);
float4x4 g_IView : register(c12);
sampler g_Noise_sampler : register(s0);
float4 g_ShadowFarInv : register(c184);
float4 g_ShadowForWin : register(c185);
float4x4 g_ShadowView : register(c32);
float4x4 g_ShadowViewProj : register(c28);
float4 g_TargetUvParam : register(c194);
float4x4 g_ViewProjection : register(c8);
sampler g_Z_sampler : register(s6);
float4 g_noiseParam : register(c187);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0.xy = g_TargetUvParam.xy + i.texcoord.xy;
	r0 = tex2D(g_Z_sampler, r0);
	r0.z = r0.x * g_CameraParam.y + g_CameraParam.x;
	o.xyw = r0.xyx * 1 + float3(0, 0, 1);
	r0.xy = r0.zz * i.texcoord1.xy;
	r1.z = -r0.z;
	r1.xy = r0.xy * i.texcoord1.zw;
	r1.w = 1;
	r0.x = dot(r1, transpose(g_IView)[0]);
	r0.y = dot(r1, transpose(g_IView)[1]);
	r0.z = dot(r1, transpose(g_IView)[2]);
	r0.w = dot(r1, transpose(g_IView)[3]);
	r1.x = dot(r0, transpose(g_ViewProjection)[3]);
	r1.x = 1 / r1.x;
	r1.y = dot(r0, transpose(g_ViewProjection)[2]);
	r2 = r1.y * r1.x + -g_ShadowFarInv.y;
	r1 = r1.y * -r1.x + g_ShadowFarInv.z;
	clip(r1);
	clip(r2);
	r1.x = dot(r0, transpose(g_ShadowView)[2]);
	r2 = -r1.x;
	r1.x = abs(r1.x) * g_ShadowFarInv.x;
	r1.x = -r1.x + g_ShadowForWin.y;
	r1.x = r1.x + 1;
	clip(r2);
	r1.y = dot(r0, transpose(g_ShadowViewProj)[3]);
	r1.y = 1 / r1.y;
	r2.x = dot(r0, transpose(g_ShadowViewProj)[0]);
	r2.y = dot(r0, transpose(g_ShadowViewProj)[1]);
	r0 = r1.y * r2.xyxy;
	r0 = r0 * float4(0.5, -0.5, 0.5, -0.5) + 0.5;
	r0 = r0 + g_TargetUvParam.xyxy;
	r1.yz = r0.zw + -0.001;
	r2 = r1.y;
	clip(r2);
	r2 = r1.z;
	r1.yz = r1.yz;
	clip(r2);
	r2.xy = -r0.zw + 0.999;
	r3 = r2.x;
	clip(r3);
	r3 = r2.y;
	r2.xy = r2.xy;
	clip(r3);
	r3 = tex2D(Shadow_Tex_sampler, r0.zwzw);
	r1.w = r1.x + -r3.x;
	r1.w = (-r1.w >= 0) ? 0 : 1;
	r2.z = g_ShadowForWin.z;
	r3 = r2.z * float4(0.00036621094, 0, 0.00061035156, 0) + r0.zwzw;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r3 = tex2D(Shadow_Tex_sampler, r3.zwzw);
	r2.w = r1.x + -r3.x;
	r2.w = (-r2.w >= 0) ? 0 : 0.45;
	r3.x = r1.x + -r4.x;
	r3.x = (-r3.x >= 0) ? 0 : 0.8;
	r1.w = r1.w + r3.x;
	r1.w = r2.w + r1.w;
	r3 = r2.z * float4(-0.00036621094, 0, -0.00061035156, 0) + r0.zwzw;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r3 = tex2D(Shadow_Tex_sampler, r3.zwzw);
	r2.w = r1.x + -r3.x;
	r2.w = (-r2.w >= 0) ? 0 : 0.45;
	r3.x = r1.x + -r4.x;
	r3.x = (-r3.x >= 0) ? 0 : 0.8;
	r1.w = r1.w + r3.x;
	r1.w = r2.w + r1.w;
	r3 = r2.z * float4(0, 0.00036621094, 0, 0.00061035156) + r0.zwzw;
	r0 = r2.z * float4(0, -0.00036621094, 0, -0.00061035156) + r0;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r3 = tex2D(Shadow_Tex_sampler, r3.zwzw);
	r2.z = r1.x + -r3.x;
	r2.z = (-r2.z >= 0) ? 0 : 0.45;
	r2.w = r1.x + -r4.x;
	r2.w = (-r2.w >= 0) ? 0 : 0.8;
	r1.w = r1.w + r2.w;
	r1.w = r2.z + r1.w;
	r3 = tex2D(Shadow_Tex_sampler, r0);
	r0 = tex2D(Shadow_Tex_sampler, r0.zwzw);
	r0.x = -r0.x + r1.x;
	r0.y = r1.x + -r3.x;
	r0.y = (-r0.y >= 0) ? 0 : 0.8;
	r0.y = r0.y + r1.w;
	r0.x = (-r0.x >= 0) ? 0 : 0.45;
	r0.x = r0.x + r0.y;
	r0.yz = frac(-r1.yz);
	r0.yz = r0.yz + r1.yz;
	r0.yz = -r0.yz + 1;
	r1.xy = max(r0.yz, 0);
	r0.x = r0.x * 0.16666667 + r1.x;
	r0.yz = frac(-r2.xy);
	r0.yz = r0.yz + r2.xy;
	r0.yz = -r0.yz + 1;
	r1.xz = max(r0.yz, 0);
	r0.x = r0.x + r1.x;
	r0.x = r1.z + r0.x;
	r0.x = r1.y + r0.x;
	r0.x = -r0.x + 1;
	r0.yz = i.texcoord.xy * g_noiseParam.xy + g_noiseParam.zw;
	r1 = tex2D(g_Noise_sampler, r0.yzzw);
	r1.x = r1.x;
	o.z = r0.x * -r1.x + 1;

	return o;
}
