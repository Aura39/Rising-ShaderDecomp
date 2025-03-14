sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
float4 CubeParam : register(c42);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s2);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap_sampler : register(s3);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c43);
float4x4 viewInverseMatrix : register(c12);

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.x = 1 / r0.w;
	r0.xyz = r0.www * r0.xyz;
	r0.w = -r1.x + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.xy + r2.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r1.w = r2.x * i.texcoord2.w;
	r1.xyz = r1.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r2.xyz = normalize(r1.xyz);
	r0.x = dot(r0.xyz, r2.xyz);
	r0.xyz = r0.xxx * point_light1.xyz;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.w = 1 / r0.w;
	r1.xyz = r0.www * r1.xyz;
	r0.w = dot(r1.xyz, r2.xyz);
	r1.xyz = r0.www * muzzle_light.xyz;
	r0.w = -r1.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.x = dot(lightpos.xyz, r2.xyz);
	r1.y = r1.x;
	r3.xyz = r1.yyy * light_Color.xyz;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r3 = g_All_Offset + i.texcoord;
	r4 = tex2D(Color_1_sampler, r3);
	r3 = tex2D(Color_2_sampler, r3.zwzw);
	r1.zw = -r4.yy + r4.xz;
	r3.w = max(abs(r1.z), abs(r1.w));
	r1.z = r3.w + -0.015625;
	r1.w = (-r1.z >= 0) ? 0 : 1;
	r1.z = (r1.z >= 0) ? -0 : -1;
	r1.z = r1.z + r1.w;
	r1.z = (r1.z >= 0) ? -r1.z : -0;
	r4.xz = (r1.zz >= 0) ? r4.yy : r4.xz;
	r3.xyz = r3.xyz + r4.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r4.xyz = r3.xyz * ambient_rate.xyz;
	r4.xyz = r4.xyz * ambient_rate_rate.xyz;
	r1.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = -r1.z + r1.x;
	r1.x = r1.x + 1;
	r0.xyz = r4.xyz * r1.xxx + r0.xyz;
	r4.x = dot(r2.xyz, transpose(viewInverseMatrix)[0].xyz);
	r4.y = dot(r2.xyz, transpose(viewInverseMatrix)[1].xyz);
	r4.z = dot(r2.xyz, transpose(viewInverseMatrix)[2].xyz);
	r1.x = dot(i.texcoord4.xyz, r4.xyz);
	r1.x = r1.x + r1.x;
	r5.xyz = r4.xyz * -r1.xxx + i.texcoord4.xyz;
	r5.w = -r5.z;
	r5 = tex2D(cubemap_sampler, r5.xyww);
	r5 = r5 * ambient_rate_rate.w;
	r1.xzw = r2.www * r5.xyz;
	r2.w = r5.w * CubeParam.y + CubeParam.x;
	r1.xzw = r1.xzw * r2.www;
	r4.xyz = r3.xyz * r1.xzw;
	r3.xyz = r3.xyz + specularParam.www;
	r5.xyz = r4.xyz * CubeParam.zzz + r0.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r4.xyz + r5.xyz;
	r2.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r2.w = 1 / sqrt(r2.w);
	r4.xyz = -i.texcoord1.xyz * r2.www + lightpos.xyz;
	r5.xyz = normalize(r4.xyz);
	r2.x = dot(r5.xyz, r2.xyz);
	r3.w = pow(r2.x, specularParam.z);
	r2.y = (-r1.y >= 0) ? 0 : 1;
	r1.y = r1.y * r2.y;
	r2.x = (-r2.x >= 0) ? 0 : r2.y;
	r2.x = r3.w * r2.x;
	r2.yzw = r1.yyy * light_Color.xyz;
	r2.xyz = r2.xxx * r2.yzw;
	r2.xyz = r4.www * r2.xyz;
	r2.xyz = r0.www * r2.xyz;
	r0.w = abs(specularParam.x);
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r2.xyz * r3.xyz + r0.xyz;
	r2.z = CubeParam.z;
	r0.w = -r2.z + 1;
	r0.xyz = r1.xzw * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
